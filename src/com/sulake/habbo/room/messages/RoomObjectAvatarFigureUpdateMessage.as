package com.sulake.habbo.room.messages
{
   public class RoomObjectAvatarFigureUpdateMessage extends RoomObjectUpdateStateMessage
   {
       
      
      private var var_692:String;
      
      private var var_2599:String;
      
      private var var_1060:String;
      
      public function RoomObjectAvatarFigureUpdateMessage(param1:String, param2:String = null, param3:String = null)
      {
         super();
         this.var_692 = param1;
         this.var_1060 = param2;
         this.var_2599 = param3;
      }
      
      public function get figure() : String
      {
         return this.var_692;
      }
      
      public function get race() : String
      {
         return this.var_2599;
      }
      
      public function get gender() : String
      {
         return this.var_1060;
      }
   }
}
