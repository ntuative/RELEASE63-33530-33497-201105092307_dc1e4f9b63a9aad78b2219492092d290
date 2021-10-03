package com.sulake.habbo.communication.messages.parser.notifications
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   public class UnseenItemsParser implements IMessageParser
   {
       
      
      private var _items:Map;
      
      public function UnseenItemsParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this._items = new Map();
         var _loc4_:int = param1.readInteger();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = param1.readInteger();
            _loc3_ = [];
            _loc6_ = param1.readInteger();
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               _loc3_.push(param1.readInteger());
               _loc7_++;
            }
            this._items.add(_loc2_,_loc3_);
            _loc5_++;
         }
         return true;
      }
      
      public function getCategories() : Array
      {
         return this._items.getKeys();
      }
      
      public function getItemsByCategory(param1:int) : Array
      {
         return this._items.getValue(param1);
      }
   }
}
