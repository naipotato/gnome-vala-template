[GtkTemplate (ui = "/com/nahuelwexd/GnomeValaTemplate/MainWindow.ui")]
sealed class GnomeValaTemplate.MainWindow : Gtk.ApplicationWindow {
    private uint _resize_id = 0;
    private Settings _settings = new Settings (Config.APPLICATION_ID);

    public MainWindow (Application app) {
        Object (application: app);
    }

    construct {
        #if DEVEL
            this.add_css_class ("devel");
        #endif

        this.default_width = this._settings.get_int ("window-width");
        this.default_height = this._settings.get_int ("window-height");

        if (this._settings.get_boolean ("is-maximized")) {
            this.maximize ();
        }
    }

    [GtkCallback]
    private void save_window_size () {
        if (this._resize_id != 0) {
            Source.remove (this._resize_id);
        }

        this._resize_id = Timeout.add (100, () => {
            this._resize_id = 0;

            if (this.maximized) {
                this._settings.set_boolean ("is-maximized", true);
                return Source.REMOVE;
            }

            this._settings.set_boolean ("is-maximized", false);
            this._settings.set_int ("window-width", this.default_width);
            this._settings.set_int ("window-height", this.default_height);

            return Source.REMOVE;
        });
    }
}
