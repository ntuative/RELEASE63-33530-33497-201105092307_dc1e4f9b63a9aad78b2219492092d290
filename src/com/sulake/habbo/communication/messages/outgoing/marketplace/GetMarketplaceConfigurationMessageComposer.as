package com.sulake.habbo.communication.messages.outgoing.marketplace
{
   import com.sulake.core.communication.messages.IMessageComposer;
   
   public class GetMarketplaceConfigurationMessageComposer implements IMessageComposer
   {
       
      
      public function GetMarketplaceConfigurationMessageComposer()
      {
         super();
      }
      
      public function getMessageArray() : Array
      {
         return new Array();
      }
      
      public function dispose() : void
      {
      }
   }
}
