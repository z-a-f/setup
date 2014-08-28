;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Roddy's Adice mode for emacs, to use it make sure this file is
;; called adice-mode.el and put something like the following line in
;; your ~/.emacs file:
;;
;; (load "~/somewhere/adice-mode")
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; CUSTOMISABLE VARIABLES: change these in your .emacs file after the
;; (load "~/somewhere/adice-mode") command with something like:
;;
;; (setq adice-tab-width 8)
;; (setq adice-toggle-comment-string "***> ")
;; (setq adice-searchpath '("." "~/models" "/cad/cadtools/cadlib/ep106/adice/new/"))
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; CHOOSING COLOURS: set normal foreground/background/cursor colours with
;; (1) An entry in ~/.Xdefaults, update with: % xrdb ~/.Xdefaults
;; (2) % emacs -fg white -bg black -cr yellow filename ...
;;
;; To change specific highlighting used by adice-mode.el go to menu:
;; help->customise->face (emacs) or options->customise->face (xemacs)
;;  and change the colours for the following faces used by adice-mode.el:
;;
;; font-lock-string-face ("for strings like this")
;; font-lock-keyword-face (if, else, endif, do, enddo, use, throw, macro),
;; font-lock-function-name-face (include, keep, sim, go, print),
;; font-lock-variable-name-face (gmin, reltolv, method, boltz, tdegc), 
;; font-lock-reference-face (||, =, ==).
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar adice-tab-width 4 "*TAB stop width in adice.")
(defvar adice-toggle-comment-string "*| "
  "*A special type of comment string at the start of a line which can
be toggled on and off with the \\[adice-toggle-comment] command.")
(defvar adice-searchpath '("." "../use" "~/use"
			   "/usr/cadtools/bin/xadice5.dir/a5genlib/models")
  "Directories where \\[adice-find-file] looks for files.")
(defvar adice-searchpath-suffix-list '("" ".use" ".inc" ".ckt" ".mod" ".subckt")
  "File suffix list to try when \\[adice-find-file] is looking for files.")

;; Set font-lock (nice colours) in adice mode, leave others as before ...
(require 'font-lock)
;; Uncomment this line if you want ALL files (C++, perl etc)
;; appropriately 'fontified' according to mode:
;; (if (featurep 'xemacs) (font-lock-mode 1) (global-font-lock-mode t) )
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst adice-font-lock-keywords
  (list
   ;; comments: first non-whitespace is '*'
   '("^[ \\\t]*\\*.*" . font-lock-comment-face)

   ;; strings
   ;; (shown without delimiting) aim to match:
   ;; '"' then either of '\.' or '[^"]' then final '"'
   '("\"\\(\\\\.\\|[^\"\\]\\)*\"" . font-lock-string-face)

   ;; adice5 keywords - just flow of control words, definition type words here
   (cons
    (concat "\\<\\("
	     (mapconcat
	      'identity
	      '(
		"break"
		"catch"
		"define"
		"do"
		"enddo"
		"enddefine"
		"endif"
		"endwhile"
		"else"
		"elseif"
		"endcatch"
		"enddefine"
		"endmacro"
		"eval"
		"evaluate"
		"exit"
		"if"
		"macro"
		"next"
		"radar"
		"raise"
		"return"
		"system"
		"throw"
		"unmacro"
		"use"
		"while"
		)
	      "\\|")
	     "\\)\\>")
    font-lock-keyword-face)

   ;; built-in functions
   (cons
    (concat "\\<\\("
	     (mapconcat
	      'identity
	      '(
		"adi_file"
		"adi_info"
		"alert"
		"alter"
		"beep"
		"by"
		"clear"
		"close"
		"command"
		"continue"
		"dec"
		"delete"
		"demand"
		"dimension"
		"display"
		"execute"
		"fop"
		"from"
		"freq"
		"go"
		"help"
		"hhistogram"
		"histogram"
		"hplot"
		"hsmith"
		"include"
		"keep"
		"label"
		"library"
		"load"
		"local"
		"monitor"
		"monte"
		"nic"
		"noise"
		"nsave"
		"nst"
		"open"
		"optimize"
		"path"
		"pcap"
		"plm"
		"plot"
		"power"
		"printf?"
		"probe"
		"profile"
		"pss"
		"randomize"
		"read"
		"reset"
		"rot"
		"save"
		"sdf"
		"sensitivity"
		"set"
		"show"
		"sim"
		"simulate"
		"size"
		"smith"
		"sprintf"
		"sscanf"
		"sweep"
		"to"
		"trav"
		"traverse"
		"type"
		"unknown_voltage"
		"unset"
		"window"
		)
	      "\\|")
	     "\\)\\>")
    font-lock-function-name-face)
;;    font-lock-builtin-face)

   ;; variables and constants ... update this with a 
   ;; grep for <strong> in /usr/cadtools/bin/xadice5.dir/html/vars.html
   (cons
    (concat "\\<\\("
	     (mapconcat
	      'identity
	      '(
		"abstol"
		"abstolc"
		"abstolr"
		"adice4_diagnostics"
		"alert_start"
		"alert_state"
		"alert_trans"
		"alog_file_name"
		"analog_unknown_res"
		"auto_rot_at_go"
		"balloon_help"
		"boltz"
		"capacitor_current_algo"
		"charge"
		"check_ckt_time_stamp"
		"check_model_time_stamps"
		"chgtol"
		"color_assignment"
		"complex_number_format"
		"continue_on_use_error"
		"continue_on_use_interrupt"
		"crop_on_y_relimit"
		"cs_ac_variants"
		"ctok"
		"curve_selector_version"
		"datserv_tol_factor"
		"dcpoly_damping"
		"dcpoly_limiting_alg"
		"defad"
		"defas"
		"default_bus_radix"
		"default_delay_f"
		"default_delay_r"
		"default_delay_t"
		"default_dsw_on_res"
		"default_logic_high_res"
		"default_logic_low_res"
		"default_plot_type"
		"defl"
		"defnrd"
		"defnrs"
		"defw"
		"diagonal_pivoting"
		"digital_grid_height"
		"dsw_inf_thresh"
		"draw_curve_labels"
		"draw_grid_border"
		"draw_grid_labels"
		"draw_grid_lines"
		"draw_title_lines"
		"dynamic_logic_capacitance"
		"dynamic_logic_mode"
		"echo"
		"enable_cloning"
		"eps0"
		"epsox"
		"epssil"
		"error_on_unset_var"
		"fft_first_point"
		"fluxlinkagetol"
		"freq"
		"function_call_limit"
		"gmin"
		"gmintype"
		"grid_spacing"
		"high"
		"high_threshold"
		"high_voltage"
		"hinit"
		"hmax"
		"hmax_factor"
		"hmin"
		"hmin_diagnostic_factor"
		"hold_nics"
		"inches_per_grid_line"
		"indep_numdigits"
		"infinity"
		"init_debug_level"
		"init_logic_value"
		"intercept_window_right"
		"intercept_window_width"
		"interval"
		"isw_algo"
		"itl1"
		"itl2"
		"itl3"
		"itl4"
		"itldcsw"
		"itlpss_fixed"
		"itlpss_newton"
		"keep_node_charge"
		"label_placement"
		"label_tail_end"
		"limiting_alg"
		"limiting_rev_bias"
		"logic_off_res"
		"low"
		"low_threshold"
		"low_voltage"
		"lteratio"
		"lte_formula"
		"lte_step_scale"
		"lvldc"
		"lvldcsw"
		"lvlpss"
		"lvltim"
		"matrix_package_version"
		"max_alert"
		"max_contention_messages"
		"max_label_length"
		"max_newton_delta_v"
		"max_sim_errors"
		"maxcap"
		"maxinductance"
		"maxord"
		"method"
		"min_switch_contention"
		"minresistance"
		"mindb"
		"monitor_level"
		"monte"
		"nic_expire_algo"
		"nicnst0"
		"nicnstr"
		"nicnstri"
		"nics_expire_time"
		"noise_sort_order"
		"notation"
		"num_neg_scans"
		"number_of_fields"
		"numdigits"
		"numvers"
		"outlim_damping"
		"outlim_limiting_alg"
		"paracap"
		"phasemax"
		"phasewrap"
		"pi"
		"platform"
		"plot_spool_command"
		"plot_update_interval"
		"plt_numdigits"
		"profile_count_init"
		"profile_print_limit"
		"profile_timer_interval"
		"pss_completed_iters"
		"pss_init_periods"
		"pss_save_periods"
		"pss_source_period_tol"
		"pssratio"
		"ptype"
		"quitquery"
		"rad"
		"radar_timeout"
		"raise_destination"
		"ramptime"
		"release"
		"reltol"
		"reltolc"
		"reltoli"
		"reltolq"
		"reltolr"
		"reltolv"
		"restore_sweep_variable"
		"rng_version"
		"root2"
		"rot_power_names"
		"runmode"
		"savetime"
		"save_node_aliases"
		"scatflg"
		"sdf_min_typ_max"
		"sen_norm"
		"settletime"
		"shared_radar"
		"show_cursor_channel"
		"sim_tran_init_algo"
		"smallest_sparse_matrix"
		"smith_chart_type"
		"smith_data_type"
		"smith_freq_annot"
		"special_analog_grids"
		"start_radar_at_go_time"
		"status_notation"
		"status_numdigits"
		"std_behav_model_dir"
		"std_script_dir"
		"stolfactor"
		"stop_on_alert"
		"swap_limit"
		"sweep_off_storage"
		"symbol_spacing"
		"tdegc"
		"tdevcmax"
		"time"
		"timetol"
		"trace_file_opens"
		"traverse_limit"
		"tref"
		"twopi"
		"umoutcurrent_abstol"
		"umoutvoltage_abstol"
		"unknown"
		"unknown_line_width"
		"unknown_voltage"
		"use_adice4_diode_temp"
		"vl_pull0"
		"vl_pull1"
		"vl_strong0"
		"vl_strong1"
		"vl_supply0"
		"vl_supply1"
		"vl_weak0"
		"vl_weak1"
		"vntol"
		"vthdelta"
		"xkfet"
		"xpndc"
		"xpntr"
		)
	      "\\|")
	     "\\)\\>")
    font-lock-variable-name-face)

   ;; operators
   (cons
    (mapconcat 'identity
		'("&&" "||" "<=" "<" ">=" ">" "==" "!=" "=" "\\$")
		"\\|")
    'font-lock-reference-face)
   )
  )

(defconst adice-circuit-font-lock-keywords
  (list
   ;; comments.  any line starting with *
   '("^\*.*" . font-lock-comment-face)

   ;; strings
   '("\"\\(\\\\.\\|[^\"\\]\\)*\"" . font-lock-string-face)

   ;; block definition keywords
   (cons
    (mapconcat
     'identity
     '(
	"^\\.ENDS[ \\\t]"
	"^\\.GLOBAL[ \\\t]"
	"^\\.INCLUDE[ \\\t]"
	"^\\.MODEL[ \\\t]"
	"^\\.PARAMETER[ \\\t]"
	"^\\.SUBCKT[ \\\t]"
	"^\\.USE[ \\\t]"
	)
     "\\|")
    font-lock-keyword-face)

   ;; anything before colon is special - port name or instance name,
   ;; unless it's half a bus port number list - don't know how to do that.
   (cons
    (mapconcat
     'identity
     '(
;;       "^[ \\\t]*[^:]*[:]"
	"not a keyword"
	)
     "\\|")
    font-lock-variable-name-face)

   ;; spare colour 
   (cons
    (concat "\\<\\("
	     (mapconcat
	      'identity
	      '(
		"ADICE"
		)
	      "\\|")
	     "\\)\\>")
    font-lock-function-name-face)
;;    font-lock-builtin-face)

   ;; operators
   (cons
        (mapconcat 'identity
	       '("&" ":" "," "&&" "||" "<=" "<" ">=" ">" "==" "!=" "=" "\\$")
	       "\\|")
   'font-lock-reference-face)
  )
 )

(defun adice-tab ()
  "Tab function in adice-mode - indent the line to the column which is the
next multiple of the variable `adice-tab-width'."
  (interactive)
  (setq adice-target-column
	(* adice-tab-width (+ 1 (floor (current-column) adice-tab-width))))
  (delete-horizontal-space)
  (indent-to adice-target-column)
  )

;; file finding is different under emacs and xemacs ...
(if (featurep 'xemacs) (setq adice-file-finder 'locate-file)
  (list (require 'ffap) (setq adice-file-finder 'ffap-locate-file)))

(defun adice-find-file (filename)
  "Find the named file, looking along the path `adice-searchpath'.
Filename suffixes in the list `adice-searchpath-suffix-list' will be tried."
  (setq adice-found-file
	(if (eq adice-file-finder 'locate-file)
	     ;; Oh great, we're using xemacs locate-file function - it
	     ;; takes the path list as a list and the suffix list as a
	     ;; single colon delimited string
	    (progn
	     (setq temp-var
		   (mapconcat 'identity adice-searchpath-suffix-list ":"))
	     (locate-file filename adice-searchpath temp-var 0) )
	  (ffap-locate-file filename
			    adice-searchpath-suffix-list adice-searchpath nil)))
  (if adice-found-file
      (find-file adice-found-file)
    (if (get-buffer filename) (switch-to-buffer filename)
      (message (concat "File: \"" filename "\" not found")) )
    )
  )

(defun adice-find-file-current-word ()
  "Find the file at the cursor, looking along the path `adice-searchpath'.
Filename suffixes in the list `adice-searchpath-suffix-list' will be tried."
  (interactive)
  (if (current-word t) (adice-find-file (current-word))
    (message "No filename under cursor to find.")))

;; OK, so this is a complete fudge ...
(defun adice-word-help (word)
  "Get adice help on the specified word"
  (setq adice-word-help-dir "/usr/cadtools/bin/xadice5.dir")
  (setq adice-word-help-prog "net_browser_help")
  (setq adice-word-help-cmd (concat "csh -f -c \""
		    "setenv MY_PROG_NAME net_browser_help; "
		    "setenv MY_PROG_DIR " adice-word-help-dir "; "
		    adice-word-help-dir "/adi_wishx.exe "
		    adice-word-help-dir "/" adice-word-help-prog ".exe "
		    adice-word-help-dir " " adice-word-help-prog " " word
		    "\"") ) ;; should I put ampersand here??
  (message (concat "Searching for adice help on \"" word "\".  CTRL-g to abort."))
  (shell-command adice-word-help-cmd) )

(defun adice-current-word-help ()
  "Get adice help on the word under the cursor."
  (interactive) (adice-word-help (current-word)))
  
(defun adice-toggle-comment (&optional lines)
  "Comment/Uncomment the line by adding/removing the string
`adice-toggle-comment-string', depending on whether the line already starts
with that string.  With a numeric prefix argument, toggle commenting in that
number of lines."
  (interactive "p") (beginning-of-line)
  (if lines () (setq lines 1))
  (while (> lines 0)
    (if (string-equal adice-toggle-comment-string
		      (buffer-substring
		       (point) (+ (point) (length adice-toggle-comment-string))))
	(delete-char (length adice-toggle-comment-string))
      (insert-string adice-toggle-comment-string))
    (forward-line 1)
    (setq lines (1- lines))
    )
  )

(defun set-adice-keymap ()
  "Set my favourite key bindings for adice-mode"
  (interactive)
  (local-set-key "\t"       'adice-tab)
  (local-set-key "\M-c"     'adice-toggle-comment)
  (local-set-key [(f1)]     'adice-current-word-help)
  (local-set-key "\C-cf"    'adice-find-file-current-word)
)

(defun adice-mode ()
  "Major mode for editing adice files.  Does syntax and
keyword highlighting.  Special key commands:

\\[adice-tab]\t`adice-tab'
\\[adice-current-word-help]\t`adice-current-word-help'
\\[adice-toggle-comment]\t`adice-toggle-comment'
\\[adice-find-file-current-word]\t`adice-find-file-current-word'
"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'adice-mode)
  (setq mode-name "Adice")
  (make-local-variable 'comment-start)
  (setq comment-start "\*")
  (make-local-variable 'comment-end)
  (setq comment-end "\$")
  (make-local-variable 'comment-start-skip)
  (setq comment-start-skip "\* ")
  (make-local-variable 'font-lock-defaults)
;;  (setq font-lock-defaults '(adice-font-lock-keywords t t ((?_ . "w"))))
;; variable should be of form
;; (KEYWORDS KEYWORDS-ONLY CASE-FOLD SYNTAX-ALIST SYNTAX-BEGIN ...)
  (modify-syntax-entry ?. "w")
  (setq font-lock-defaults
	'(adice-font-lock-keywords t t
	  ((?_ . "w")
;;	   (?- . "w") ;; although '-' can sometimes be part of a word
	   (?. . "w")
	   )
	))
  (font-lock-mode 1)
  (set-adice-keymap)
  (message "Started adice-mode")
  )

(defun adice-circuit-mode ()
  "Major mode for editing adice circuit files.  Pretty basic"
  (interactive)
  (kill-all-local-variables)
  (setq major-mode 'adice-circuit-mode)
  (setq mode-name "Adice-Circuit")
  (make-local-variable 'comment-start)
  (setq comment-start "\*")
  (make-local-variable 'comment-end)
  (setq comment-end "\$")
  (make-local-variable 'comment-start-skip)
  (setq comment-start-skip "\* ")
  (make-local-variable 'font-lock-defaults)
  (modify-syntax-entry ?. "w")
  (setq font-lock-defaults '(adice-circuit-font-lock-keywords
			     t t ((?_ . "w"))))
  (font-lock-mode 1)
  (set-adice-keymap)
  (message "Started adice-circuit-mode")
  )

;; automatically start adice modes on suitable file types
(add-to-list 'auto-mode-alist '("\\.use$"     . adice-mode))
(add-to-list 'auto-mode-alist '("sims.setup$"     . adice-mode))
(add-to-list 'auto-mode-alist '("\\.mod$"     . adice-circuit-mode))
(add-to-list 'auto-mode-alist '("\\.inc$"     . adice-circuit-mode))
(add-to-list 'auto-mode-alist '("\\.ckt$"     . adice-circuit-mode))
(add-to-list 'auto-mode-alist '("\\.subckt$"  . adice-circuit-mode))

