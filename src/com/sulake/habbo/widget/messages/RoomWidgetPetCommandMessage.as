package com.sulake.habbo.widget.messages
{
   public class RoomWidgetPetCommandMessage extends RoomWidgetMessage
   {
      
      public static const const_886:String = "RWPCM_REQUEST_PET_COMMANDS";
      
      public static const const_508:String = "RWPCM_PET_COMMAND";
       
      
      private var var_1765:int = 0;
      
      private var var_178:String;
      
      public function RoomWidgetPetCommandMessage(param1:String, param2:int, param3:String = null)
      {
         super(param1);
         this.var_1765 = param2;
         this.var_178 = param3;
      }
      
      public function get petId() : int
      {
         return this.var_1765;
      }
      
      public function get value() : String
      {
         return this.var_178;
      }
   }
}
