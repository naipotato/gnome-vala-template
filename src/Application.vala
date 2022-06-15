sealed class GnomeValaTemplate.Application : Adw.Application {
    construct {
        this.application_id = Config.APPLICATION_ID;
    }

    public static int main (string[] args) {
        // See https://docs.gtk.org/glib/i18n.html
        Intl.bindtextdomain (Config.GETTEXT_PACKAGE, Config.LOCALEDIR);
        Intl.bind_textdomain_codeset (Config.GETTEXT_PACKAGE, "UTF-8");
        Intl.textdomain (Config.GETTEXT_PACKAGE);

        return new Application ().run (args);
    }

    public override void activate () {
        this.active_window?.present ();
    }

    public override void startup () {
        this.resource_base_path = Config.RESOURCE_PATH;

        base.startup ();

        Environment.set_application_name ("GNOME Vala Template");

        this.init_actions ();

        new MainWindow (this);
    }

    private void init_actions () {
        var action_entries = new ActionEntry[] {
            { "about",       this.show_about       },
            { "preferences", this.show_preferences },
            { "quit",        this.quit             },
        };

        this.add_action_entries (action_entries, this);
        this.set_accels_for_action ("app.quit", { "<Ctrl>Q" });
    }

    private void show_about () {
        var about = new Gtk.AboutDialog () {
            transient_for = this.active_window,
            modal = true,
            destroy_with_parent = true,
            // The title of the about dialog
            title = C_("about dialog", "About GNOME Vala Template"),
            logo_icon_name = Config.APPLICATION_ID,
            version = Config.VERSION,
            // A small summary about the app
            comments = C_("about dialog", "A template for GNOME apps written in Vala"),
            // TODO: Insert your website here
            // website = "https://github.com/nahuelwexd/gnome-vala-template",
            copyright = "© 2022 Nahuel Gomez",
            // TODO: Insert your license of choice here
            // license = GPL_3_0,
            authors = { "Nahuel Gomez Castro" },
            artists = { "Nahuel Gomez Castro" },
        };

        about.present ();
    }

    private void show_preferences () {
        message ("app.preferences action activated");
    }
}
