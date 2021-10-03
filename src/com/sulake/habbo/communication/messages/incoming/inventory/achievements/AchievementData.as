package com.sulake.habbo.communication.messages.incoming.inventory.achievements
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class AchievementData
   {
       
      
      private var _type:int;
      
      private var var_1437:int;
      
      private var var_304:String;
      
      private var var_2562:int;
      
      private var var_2250:int;
      
      private var var_1809:int;
      
      private var var_2561:int;
      
      private var var_2560:Boolean;
      
      private var _category:String;
      
      private var var_2563:int;
      
      public function AchievementData(param1:IMessageDataWrapper)
      {
         super();
         this._type = param1.readInteger();
         this.var_1437 = param1.readInteger();
         this.var_304 = param1.readString();
         this.var_2562 = param1.readInteger();
         this.var_2250 = param1.readInteger();
         this.var_1809 = param1.readInteger();
         this.var_2561 = param1.readInteger();
         this.var_2560 = param1.readBoolean();
         this._category = param1.readString();
         this.var_2563 = param1.readInteger();
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function get badgeId() : String
      {
         return this.var_304;
      }
      
      public function get level() : int
      {
         return this.var_1437;
      }
      
      public function get scoreLimit() : int
      {
         return this.var_2562;
      }
      
      public function get levelRewardPoints() : int
      {
         return this.var_2250;
      }
      
      public function get levelRewardPointType() : int
      {
         return this.var_1809;
      }
      
      public function get currentPoints() : int
      {
         return this.var_2561;
      }
      
      public function get finalLevel() : Boolean
      {
         return this.var_2560;
      }
      
      public function get category() : String
      {
         return this._category;
      }
      
      public function get levelCount() : int
      {
         return this.var_2563;
      }
   }
}
