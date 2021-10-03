package com.sulake.habbo.widget.messages
{
   public class RoomWidgetChatTypingMessage extends RoomWidgetMessage
   {
      
      public static const const_703:String = "RWCTM_TYPING_STATUS";
       
      
      private var var_580:Boolean;
      
      public function RoomWidgetChatTypingMessage(param1:Boolean)
      {
         super(const_703);
         this.var_580 = param1;
      }
      
      public function get isTyping() : Boolean
      {
         return this.var_580;
      }
   }
}
