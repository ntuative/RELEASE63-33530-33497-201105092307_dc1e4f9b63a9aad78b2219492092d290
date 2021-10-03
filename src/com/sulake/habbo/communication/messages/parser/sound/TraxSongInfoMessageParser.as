package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.sound.SongInfoEntry;
   
   public class TraxSongInfoMessageParser implements IMessageParser
   {
       
      
      private var var_1843:Array;
      
      public function TraxSongInfoMessageParser()
      {
         super();
      }
      
      public function get songs() : Array
      {
         return this.var_1843;
      }
      
      public function flush() : Boolean
      {
         this.var_1843 = new Array();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc7_:int = param1.readInteger();
         var _loc8_:int = 0;
         while(_loc8_ < _loc7_)
         {
            _loc2_ = param1.readInteger();
            _loc3_ = param1.readString();
            _loc4_ = param1.readString();
            _loc5_ = param1.readInteger();
            _loc6_ = param1.readString();
            _loc9_ = new SongInfoEntry(_loc2_,_loc5_,_loc3_,_loc6_,_loc4_);
            this.var_1843.push(_loc9_);
            _loc8_++;
         }
         return true;
      }
   }
}
