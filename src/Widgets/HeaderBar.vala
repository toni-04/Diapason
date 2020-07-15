public class Diapason.HeaderBar : Gtk.HeaderBar {
  //main_window property can be get(accessed) by methods, and needs to be generated at HEADERBAR CONSTRUCTION
  //used to access window attributes
  public Diapason.Window main_window { get; construct;}

  public HeaderBar (Diapason.Window window) {
    Object (
      main_window: window
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

    var stack_switcher = new Gtk.StackSwitcher ();
    //stack_switcher.homogeneous = true;//?
    stack_switcher.stack = main_window.stack;
    set_custom_title (stack_switcher);

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


    //mini button
    Gtk.Button mini_button = new Gtk.Button.with_label ("mini");
    //mini_button.get_style_context ().add_class ("suggested-action");
    mini_button.valign = Gtk.Align.CENTER;
    //attach button to the end of the hb
    pack_end (mini_button);

    mini_button.clicked.connect (switch_to_mini);


  }

  // public void switch_to_mini () {
  //   var dialog = new Gtk.Dialog.with_buttons (
  //     "Add a New Note",
  //     main_window,//the window owns the dialog
  //     Gtk.DialogFlags.MODAL | Gtk.DialogFlags.DESTROY_WITH_PARENT | Gtk.DialogFlags.USE_HEADER_BAR,
  //     "Custom Button", 1,//every button needs an ID, i.e. the int returned by
  //     "Second Button", 2, null//null stops the list
  //   );

  //   var label = new Gtk.Label ("Content dialog");
  //   //access to the body of the dialog
  //   var content_area = dialog.get_content_area ();
  //   //content_area can be used as a regular gtk widget
  //   content_area.add (label);

  //   dialog.show_all ();
  //   dialog.present ();
  // }

  public void switch_to_mini () {
    // var mini_window = new Gtk.Dialog.with_buttons (
    //   "Add a New Note",
    //   main_window,//the window owns the dialog
    //   Gtk.DialogFlags.MODAL | Gtk.DialogFlags.DESTROY_WITH_PARENT | Gtk.DialogFlags.USE_HEADER_BAR,
    //   "Custom Button", 1,//every button needs an ID, i.e. the int returned by
    //   "Second Button", 2, null//null stops the list
    // );

    // var label = new Gtk.Label ("Content dialog");
    // //access to the body of the dialog
    // var content_area = mini_window.get_content_area ();
    // //content_area can be used as a regular gtk widget
    // content_area.add (label);
    var mini_window = new Diapason.MiniWindow (main_window);
    //GLib.Signal.emit_by_name(main_window, "hide");
    main_window.hide();

    mini_window.show_all ();
    mini_window.present ();
  }
}
