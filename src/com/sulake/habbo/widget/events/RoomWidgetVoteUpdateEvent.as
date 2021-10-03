package com.sulake.habbo.widget.events
{
   public class RoomWidgetVoteUpdateEvent extends RoomWidgetUpdateEvent
   {
      
      public static const const_152:String = "RWPUE_VOTE_QUESTION";
      
      public static const const_161:String = "RWPUE_VOTE_RESULT";
       
      
      private var var_1189:String;
      
      private var var_1339:Array;
      
      private var var_1219:Array;
      
      private var var_2063:int;
      
      public function RoomWidgetVoteUpdateEvent(param1:String, param2:String, param3:Array, param4:Array = null, param5:int = 0, param6:Boolean = false, param7:Boolean = false)
      {
         super(param1,param6,param7);
         this.var_1189 = param2;
         this.var_1339 = param3;
         this.var_1219 = param4;
         if(this.var_1219 == null)
         {
            this.var_1219 = [];
         }
         this.var_2063 = param5;
      }
      
      public function get question() : String
      {
         return this.var_1189;
      }
      
      public function get choices() : Array
      {
         return this.var_1339.slice();
      }
      
      public function get votes() : Array
      {
         return this.var_1219.slice();
      }
      
      public function get totalVotes() : int
      {
         return this.var_2063;
      }
   }
}
