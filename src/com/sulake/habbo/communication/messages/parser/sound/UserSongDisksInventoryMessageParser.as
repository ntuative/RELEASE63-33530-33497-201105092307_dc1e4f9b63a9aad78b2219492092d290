package com.sulake.habbo.communication.messages.parser.sound
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.core.utils.Map;
   
   public class UserSongDisksInventoryMessageParser implements IMessageParser
   {
       
      
      private var var_378:Map;
      
      public function UserSongDisksInventoryMessageParser()
      {
         super();
         this.var_378 = new Map();
      }
      
      public function get songDiskCount() : int
      {
         return this.var_378.length;
      }
      
      public function getDiskId(param1:int) : int
      {
         if(param1 >= 0 && param1 < this.var_378.length)
         {
            return this.var_378.getKey(param1);
         }
         return -1;
      }
      
      public function getSongId(param1:int) : int
      {
         if(param1 >= 0 && param1 < this.var_378.length)
         {
            return this.var_378.getWithIndex(param1);
         }
         return -1;
      }
      
      public function flush() : Boolean
      {
         this.var_378.reset();
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInteger();
            _loc5_ = param1.readInteger();
            this.var_378.add(_loc4_,_loc5_);
            _loc3_++;
         }
         return true;
      }
   }
}
