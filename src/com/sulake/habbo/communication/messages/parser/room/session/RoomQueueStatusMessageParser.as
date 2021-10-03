package com.sulake.habbo.communication.messages.parser.room.session
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   public class RoomQueueStatusMessageParser implements IMessageParser
   {
       
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var var_1035:Map;
      
      private var var_1775:int = 0;
      
      public function RoomQueueStatusMessageParser()
      {
         this.var_1035 = new Map();
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
      
      public function get activeTarget() : int
      {
         return this.var_1775;
      }
      
      public function flush() : Boolean
      {
         this._roomId = 0;
         this._roomCategory = 0;
         this.var_1035.reset();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         this.var_1035.reset();
         var _loc2_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc6_ = param1.readString();
            _loc7_ = param1.readInteger();
            if(_loc5_ == 0)
            {
               this.var_1775 = _loc7_;
            }
            _loc4_ = new RoomQueueSet(_loc6_,_loc7_);
            _loc3_ = param1.readInteger();
            _loc8_ = 0;
            while(_loc8_ < _loc3_)
            {
               _loc4_.addQueue(param1.readString(),param1.readInteger());
               _loc8_++;
            }
            this.var_1035.add(_loc4_.target,_loc4_);
            _loc5_++;
         }
         return true;
      }
      
      public function getQueueSetTargets() : Array
      {
         return this.var_1035.getKeys();
      }
      
      public function getQueueSet(param1:int) : RoomQueueSet
      {
         return this.var_1035.getValue(param1) as RoomQueueSet;
      }
   }
}
