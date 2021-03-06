with Gtk.Main;

with Cairo_Utilities;
with Debug;

package body Callbacks is

   -- Called when 'quit' is requested
   procedure Main_Quit (Self : access Gtk.Widget.Gtk_Widget_Record'Class) is
      pragma UNREFERENCED (Self);
   begin
      Debug.Print ("Callbacks.Main_Quit");
      Cairo_Utilities.Destroy_Surface;
      Gtk.Main.Main_Quit;
   end Main_Quit;

   -- Redraw the screen from the surface. Note that the ::draw signal receives
   -- a ready-to-be-used cairo_t that is already clipped to only draw the
   -- exposed areas of the widget
   function Draw_Cb
     (Self : access Gtk.Widget.Gtk_Widget_Record'Class;
      Cr   : Cairo.Cairo_Context)
     return Boolean is
      pragma UNREFERENCED (Self);
   begin
      Cairo_Utilities.Set_Source (Cr);
      Cairo_Utilities.Paint (Cr);
      return False;
   end Draw_Cb;

   -- Create a new surface of the appropriate size to store our scribbles
   function Configure_Event_Cb
     (Self  : access Gtk.Widget.Gtk_Widget_Record'Class;
      Event : Gdk.Event.Gdk_Event_Configure)
     return Boolean is
      pragma UNREFERENCED (Event);
   begin
      Debug.Print ("Callbacks.Configure_Event_Cb");
      Cairo_Utilities.Destroy_Surface;
      Cairo_Utilities.Create_Surface_From_Widget (Self);
      Cairo_Utilities.Clear_Surface;
      return True;
   end Configure_Event_Cb;

end Callbacks;
