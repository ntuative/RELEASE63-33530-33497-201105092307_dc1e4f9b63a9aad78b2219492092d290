package com.sulake.habbo.communication.messages.incoming.navigator
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.runtime.IDisposable;
   
   public class PublicRoomData implements IDisposable
   {
       
      
      private var var_2295:String;
      
      private var var_2299:int;
      
      private var var_2298:int;
      
      private var var_2296:String;
      
      private var var_2297:int;
      
      private var var_1839:int;
      
      private var _disposed:Boolean;
      
      public function PublicRoomData(param1:IMessageDataWrapper)
      {
         super();
         this.var_2295 = param1.readString();
         this.var_2299 = param1.readInteger();
         this.var_2298 = param1.readInteger();
         this.var_2296 = param1.readString();
         this.var_2297 = param1.readInteger();
         this.var_1839 = param1.readInteger();
      }
      
      public function dispose() : void
      {
         if(this._disposed)
         {
            return;
         }
         this._disposed = true;
      }
      
      public function get disposed() : Boolean
      {
         return this._disposed;
      }
      
      public function get unitPropertySet() : String
      {
         return this.var_2295;
      }
      
      public function get unitPort() : int
      {
         return this.var_2299;
      }
      
      public function get worldId() : int
      {
         return this.var_2298;
      }
      
      public function get castLibs() : String
      {
         return this.var_2296;
      }
      
      public function get maxUsers() : int
      {
         return this.var_2297;
      }
      
      public function get nodeId() : int
      {
         return this.var_1839;
      }
   }
}
