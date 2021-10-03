package com.sulake.habbo.communication.messages.parser.moderation
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class ModeratorInitMessageParser implements IMessageParser
   {
       
      
      private var _data:ModeratorInitData;
      
      public function ModeratorInitMessageParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._data = new ModeratorInitData(param1);
         return true;
      }
      
      public function get data() : ModeratorInitData
      {
         return this._data;
      }
   }
}
