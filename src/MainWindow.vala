[GtkTemplate (ui = "/com/nahuelwexd/GnomeValaTemplate/MainWindow.ui")]
sealed class GnomeValaTemplate.MainWindow : Gtk.ApplicationWindow {
    public MainWindow (Application app) {
        Object (application: app);
    }

    construct {
        #if DEVEL
            this.add_css_class ("devel");
        #endif
    }
}
