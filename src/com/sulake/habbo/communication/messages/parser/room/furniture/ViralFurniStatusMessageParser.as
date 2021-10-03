package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   public class ViralFurniStatusMessageParser implements IMessageParser
   {
       
      
      private var var_177:String;
      
      private var var_194:int;
      
      private var _roomId:int = 0;
      
      private var _roomCategory:int = 0;
      
      private var var_1388:int = 0;
      
      private var var_406:int;
      
      private var _shareId:String;
      
      private var var_2322:String;
      
      public function ViralFurniStatusMessageParser()
      {
         super();
      }
      
      public function get campaignID() : String
      {
         return this.var_177;
      }
      
      public function get objectId() : int
      {
         return this.var_194;
      }
      
      public function get roomId() : int
      {
         return this._roomId;
      }
      
      public function get roomCategory() : int
      {
         return this._roomCategory;
      }
      
      public function get itemCategory() : int
      {
         return this.var_1388;
      }
      
      public function get shareId() : String
      {
         return this._shareId;
      }
      
      public function get status() : int
      {
         return this.var_406;
      }
      
      public function get firstClickUserName() : String
      {
         return this.var_2322;
      }
      
      public function flush() : Boolean
      {
         this._roomId = 0;
         this._roomCategory = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         this.var_177 = param1.readString();
         this.var_194 = param1.readInteger();
         this.var_406 = param1.readInteger();
         this._shareId = param1.readString();
         this.var_2322 = param1.readString();
         this.var_1388 = param1.readInteger();
         return true;
      }
   }
}
