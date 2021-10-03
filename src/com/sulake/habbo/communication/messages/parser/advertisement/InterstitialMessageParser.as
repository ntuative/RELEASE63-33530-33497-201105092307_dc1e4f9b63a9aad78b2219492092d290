package com.sulake.habbo.communication.messages.parser.advertisement
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class InterstitialMessageParser implements IMessageParser
   {
       
      
      private var _imageUrl:String;
      
      private var var_1305:String;
      
      public function InterstitialMessageParser()
      {
         super();
      }
      
      public function get imageUrl() : String
      {
         return this._imageUrl;
      }
      
      public function get clickUrl() : String
      {
         return this.var_1305;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this._imageUrl = param1.readString();
         this.var_1305 = param1.readString();
         return true;
      }
   }
}
