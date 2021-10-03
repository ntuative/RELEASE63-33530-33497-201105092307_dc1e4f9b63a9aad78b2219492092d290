package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class RoomVisualizationSettingsParser implements IMessageParser
   {
       
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var var_1977:Boolean = false;
      
      private var var_1521:Number = 1;
      
      private var _floorThicknessMultiplier:Number = 1;
      
      public function RoomVisualizationSettingsParser()
      {
         super();
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomCategory() : int
      {
         return this._roomCategory;
      }
      
      public function get wallsHidden() : Boolean
      {
         return this.var_1977;
      }
      
      public function get wallThicknessMultiplier() : Number
      {
         return this.var_1521;
      }
      
      public function get floorThicknessMultiplier() : Number
      {
         return this._floorThicknessMultiplier;
      }
      
      public function flush() : Boolean
      {
         this._roomId = 0;
         this._roomCategory = 0;
         this.var_1977 = false;
         this.var_1521 = 1;
         this._floorThicknessMultiplier = 1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         this.var_1977 = param1.readBoolean();
         this.var_1521 = Math.pow(2,0);
         this._floorThicknessMultiplier = Math.pow(2,0);
         return true;
      }
   }
}
