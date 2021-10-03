package
{
   import com.sulake.habbo.room.object.RoomObjectVisualizationFactory;
   import com.sulake.iid.IIDRoomObjectVisualizationFactory;
   import mx.core.SimpleApplication;
   
   public class HabboRoomObjectVisualizationLib extends SimpleApplication
   {
      
      public static var manifest:Class = HabboRoomObjectVisualizationLib_manifest;
      
      public static var pet_experience_bubble_png:Class = HabboRoomObjectVisualizationLib_pet_experience_bubble_png;
      
      public static var RoomObjectVisualizationFactory:Class = RoomObjectVisualizationFactory;
      
      public static var IIDRoomObjectVisualizationFactory:Class = IIDRoomObjectVisualizationFactory;
       
      
      public function HabboRoomObjectVisualizationLib()
      {
         super();
      }
   }
}
