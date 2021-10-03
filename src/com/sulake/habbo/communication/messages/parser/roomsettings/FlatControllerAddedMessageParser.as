package com.sulake.habbo.communication.messages.parser.roomsettings
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.roomsettings.FlatControllerData;
   
   public class FlatControllerAddedMessageParser implements IMessageParser
   {
       
      
      private var var_396:int;
      
      private var _data:FlatControllerData;
      
      public function FlatControllerAddedMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_396 = param1.readInteger();
         this._data = new FlatControllerData(param1);
         return true;
      }
      
      public function get flatId() : int
      {
         return this.var_396;
      }
      
      public function get data() : FlatControllerData
      {
         return this._data;
      }
   }
}
