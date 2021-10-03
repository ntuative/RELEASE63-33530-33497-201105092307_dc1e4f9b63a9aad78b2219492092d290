package
{
   import com.sulake.iid.IIDRoomRendererFactory;
   import com.sulake.room.renderer.RoomRendererFactory;
   import mx.core.SimpleApplication;
   
   public class RoomSpriteRendererLib extends SimpleApplication
   {
      
      public static var manifest:Class = RoomSpriteRendererLib_manifest;
      
      public static var RoomSpriteRendererFactory:Class = RoomRendererFactory;
      
      public static var IIDRoomSpriteRendererFactory:Class = IIDRoomRendererFactory;
       
      
      public function RoomSpriteRendererLib()
      {
         super();
      }
   }
}
