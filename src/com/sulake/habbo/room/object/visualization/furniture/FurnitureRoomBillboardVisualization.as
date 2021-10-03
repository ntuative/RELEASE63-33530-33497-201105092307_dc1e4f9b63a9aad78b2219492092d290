package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.habbo.room.object.RoomObjectVariableEnum;
   import com.sulake.room.object.IRoomObjectModel;
   
   public class FurnitureRoomBillboardVisualization extends FurnitureRoomBrandingVisualization
   {
       
      
      public function FurnitureRoomBillboardVisualization()
      {
         super();
      }
      
      override protected function getAdClickUrl(param1:IRoomObjectModel) : String
      {
         return param1.getString(RoomObjectVariableEnum.const_390);
      }
   }
}
