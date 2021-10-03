package com.sulake.habbo.communication.messages.outgoing.room.furniture
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class OpenPetPackageMessageComposer implements IMessageComposer
   {
       
      
      private var var_194:int;
      
      private var var_2171:String;
      
      public function OpenPetPackageMessageComposer(param1:int, param2:String)
      {
         super();
         this.var_194 = param1;
         this.var_2171 = param2;
      }
      
      public function getMessageArray() : Array
      {
         return [this.var_194,this.var_2171];
      }
      
      public function dispose() : void
      {
      }
   }
}
