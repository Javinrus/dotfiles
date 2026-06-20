; This was modified as of version 4.20

; Edit the keybinds here, Thunar automatically rearranges accels.scm into a generated mess

; General
(gtk_accel_path "<Actions>/ThunarWindow/new-window" "") ; I just use SUPER + F
(gtk_accel_path "<Actions>/ThunarWindow/close-window" "") ; I just use SUPER + C
(gtk_accel_path "<Actions>/ThunarShortcutsPane/sendto-shortcuts" "")

; Navigation
(gtk_accel_path "<Actions>/ThunarWindow/view-side-pane-tree" "")
(gtk_accel_path "<Actions>/ThunarWindow/view-menubar" "")
(gtk_accel_path "<Actions>/ThunarWindow/menu" "<Primary>m")
(gtk_accel_path "<Actions>/ThunarWindow/open-parent" "BackSpace")

; Actions
(gtk_accel_path "<Actions>/ThunarActionManager/open-with-other" "<Primary>Return")
(gtk_accel_path "<Actions>/ThunarStandardView/properties" "<Alt>Return")
(gtk_accel_path "<Actions>/ThunarStandardView/set-default-app" "<Shift>Return")
(gtk_accel_path "<Actions>/ThunarStandardView/duplicate" "<Primary>d")
(gtk_accel_path "<Actions>/ThunarStandardView/make-link" "<Primary>n") ; Make symlink
(gtk_accel_path "<Actions>/ThunarStandardView/rename" "<Shift>r")
(gtk_accel_path "<Actions>/ThunarWindow/empty-trash" "<Primary><Shift>Delete")
(gtk_accel_path "<Actions>/ThunarActionManager/redo" "<Primary>y")
(gtk_accel_path "<Actions>/ThunarActionManager/open" "")
(gtk_accel_path "<Actions>/ThunarActionManager/restore" "<Alt>r")

; Sorting
(gtk_accel_path "<Actions>/ThunarStandardView/toggle-sort-order" "<Shift>o")
(gtk_accel_path "<Actions>/ThunarStandardView/sort-by-name" "<Shift>n")
(gtk_accel_path "<Actions>/ThunarStandardView/sort-by-size" "<Shift>s")
(gtk_accel_path "<Actions>/ThunarStandardView/sort-by-type" "<Shift>t")

; Custom, see uca.xml and the UIDs
(gtk_accel_path "<Actions>/ThunarActions/uca-action-1778080439437750-1" "<Primary>q")

(gtk_accel_path "<Actions>/ThunarWindow/view-side-pane-shortcuts" "")
(gtk_accel_path "<Actions>/ThunarActionManager/open-in-new-tab" "<Shift>f")

(gtk_accel_path "<Actions>/ThunarWindow/close-all-windows" "<Primary><Shift>c")

(gtk_accel_path "<Actions>/ThunarStandardView/create-document" "<Primary>i")
(gtk_accel_path "<Actions>/ThunarStandardView/create-folder" "<Shift>i")
(gtk_accel_path "<Actions>/ThunarWindow/toggle-side-pane" "<Primary>p")
