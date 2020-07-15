public class Application : Gtk.Application {

  public Application () {
    Object (
      application_id: "com.github.toni-04.diapason",
      flags: ApplicationFlags.FLAGS_NONE
    );
  }

  protected override void activate () {
    var window = new Diapason.Window (this);


    add_window (window);
  }
}
