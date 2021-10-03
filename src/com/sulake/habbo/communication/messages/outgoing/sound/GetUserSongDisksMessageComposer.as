package com.sulake.habbo.communication.messages.outgoing.sound
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IDisposable;
   
   public class GetUserSongDisksMessageComposer implements IMessageComposer, IDisposable
   {
       
      
      private var var_31:Array;
      
      public function GetUserSongDisksMessageComposer()
      {
         this.var_31 = new Array();
         super();
      }
      
      public function getMessageArray() : Array
      {
         return this.var_31;
      }
      
      public function dispose() : void
      {
         this.var_31 = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}
