public class Diapason.MiniHeaderBar : Gtk.HeaderBar {
  public Diapason.MiniWindow mini_window { get; construct; }

  public MiniHeaderBar ( Diapason.MiniWindow window) {
    Object (
      mini_window: window
    );
  }

  construct {
/*    // set title
    title = "Diapason";
    //set subtitle
    subtitle = "Ready to tune";
*/

    show_close_button = true;
    set_decoration_layout("close:");
    //let hb be one with window
    get_style_context ().add_class (Gtk.STYLE_CLASS_FLAT);
    has_subtitle = false;

    //add icon button -> submenu (popup menu)
    var menu_button = new Gtk.MenuButton();
    menu_button.image = new Gtk.Image.from_icon_name ("open-menu-symbolic", Gtk.IconSize.LARGE_TOOLBAR);
    menu_button.valign = Gtk.Align.CENTER;

    var main_menu = new GLib.Menu ();

    // var partition_menu = new GLib.Menu ();
    // main_menu.append_submenu ("Monitored partition", partition_menu);
    // main_menu.append ("Quit", "app.quit");
    var popover = new Gtk.Popover.from_model(null, main_menu);
    menu_button.popover = popover;
    //attach button to the end of hb
    pack_end (menu_button);


    //add button
    Gtk.Button main_button = new Gtk.Button.with_label ("main");
    //add_button.get_style_context ().add_class ("suggested-action");
    main_button.valign = Gtk.Align.CENTER;
    //attach button to the start of the hb
    pack_end (main_button);

    main_button.clicked.connect (switch_to_main);

  }

  public void switch_to_main () {
    //GLib.Signal.emit_by_name(mini_window, "delete-event");
    mini_window.hide();
    mini_window.main_window.show();
  }

}
