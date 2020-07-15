public class Diapason.MiniWindow : Gtk.ApplicationWindow {
  public GLib.Settings settings;
  //the window that 'owns' the mini self
  public Diapason.Window main_window { get; construct; }

  public MiniWindow (Diapason.Window window) {
    Object (
    //application is an inherited attribute
      application: window.application,
      main_window: window
    );


    get_style_context().add_class("rounded");
    resizable = false;
    set_size_request(225, 300);
  }

  construct {
    settings = new GLib.Settings ("com.github.toni-04.diapason");

    move (settings.get_int ("pos-x"), settings.get_int ("pos-y"));

    //delete_event, i.e. click on X
    delete_event.connect (e => {
      main_window.destroy();
      return before_destroy ();
    });

    // //hide event
    GLib.Signal.connect (this, "hide", (GLib.Callback) before_hide, null);


    //generate hb w\ attached stack
    var headerbar = new Diapason.MiniHeaderBar (this);
    //place it at the center, instead of title
    set_titlebar (headerbar);

    show_all ();

  }

  public bool before_destroy () {
    //do things before triggering destruction
    int x, y;

    // //store
    get_position (out x, out y);

    settings.set_int ("pos-x", x);
    settings.set_int ("pos-y", y);

    return false;//send delete signal, actually close the window
  }

  public void before_hide () {
    int x, y;

    //store
    get_position (out x, out y);

    settings.set_int ("pos-x", x);
    settings.set_int ("pos-y", y);
  }

}
