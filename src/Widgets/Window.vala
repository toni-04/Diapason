//Diapason namespace is here created for first time
public class Diapason.Window : Gtk.ApplicationWindow {
  public GLib.Settings settings;
  public Gtk.Stack stack {get; set; }

  public Window (Gtk.Application app) {
    Object (
    //application is an inherited attribute
      application: app
    );

    get_style_context().add_class("rounded");
    resizable = false;
    // set_size_request (550, 714);
    // Gdk.Geometry hints = Gdk.Geometry();
    // hints.min_aspect = 0.8;
    // hints.max_aspect = 0.8;
    // // hints.min_height = 360;
    // // hints.min_width = 360;

    // //get_window().
    // set_geometry_hints (
    //   null,
    //   hints,
    //   //Gdk.WindowHints.MIN_SIZE |
    //   Gdk.WindowHints.ASPECT
    //   //Gdk.WindowHints.USER_POS |
    //   //Gdk.WindowHints.USER_SIZE
    // );
  }

  construct {

    window_position = Gtk.WindowPosition.CENTER;
    set_default_size (350, 180);

    settings = new GLib.Settings ("com.github.toni-04.diapason");

    move (settings.get_int ("pos-x"), settings.get_int ("pos-y"));
    resize (settings.get_int ("window-width"), settings.get_int ("window-height"));

    //delete_event, i.e. click on X
    delete_event.connect (e => {
      return before_destroy ();
    });

    // //hide event
    GLib.Signal.connect (this, "hide", (GLib.Callback) before_hide, null);
    //show
    GLib.Signal.connect (this, "show", (GLib.Callback) after_show, null);

    //stack
    stack = new Gtk.Stack ();
    stack.expand = true;
    //two pages
    var input = new Gtk.Grid ();
    input.add (new Gtk.Label ("tune page"));
    var output = new Gtk.Grid ();
    output.add (new Gtk.Label ("listen page"));
    //adding pages to the stack
    stack.add_titled (input, "tune", "Tune");
    stack.add_titled (output, "output", "Listen");
    //add to the window
    add (stack);

    //generate hb w\ attached stack
    var headerbar = new Diapason.HeaderBar (this);
    //place it at the center, instead of title
    set_titlebar (headerbar);

    show_all ();
  }

  public bool before_destroy () {
    //do things before triggering destruction
    int width, height, x, y;

    //store
    //get_size (out width, out height);
    get_position (out x, out y);

    settings.set_int ("pos-x", x);
    settings.set_int ("pos-y", y);
    // settings.set_int ("window-width", width);
    // settings.set_int ("window-height", height);

    return false;//send delete signal, actually close the window
  }

  public void before_hide () {
    //do things before triggering destruction
    // int width, height, x, y;

    // //store
    // get_size (out width, out height);
    // get_position (out x, out y);

    // settings.set_int ("pos-x", x);
    // settings.set_int ("pos-y", y);
    // settings.set_int ("window-width", width);
    // settings.set_int ("window-height", height);

  }

  public void after_show () {

    move (settings.get_int ("pos-x"), settings.get_int ("pos-y"));
    //resize (settings.get_int ("window-width"), settings.get_int ("window-height"));

    //restore

  }


}
