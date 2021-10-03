package com.sulake.habbo.quest
{
   import com.sulake.habbo.communication.messages.incoming.inventory.achievements.AchievementData;
   
   public class AchievementCategory
   {
       
      
      private var var_2503:String;
      
      private var _achievements:Array;
      
      public function AchievementCategory(param1:String)
      {
         this._achievements = new Array();
         super();
         this.var_2503 = param1;
      }
      
      public function add(param1:AchievementData) : void
      {
         this._achievements.push(param1);
      }
      
      public function update(param1:AchievementData) : void
      {
         var _loc3_:* = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._achievements.length)
         {
            _loc3_ = this._achievements[_loc2_];
            if(_loc3_.type == param1.type)
            {
               this._achievements[_loc2_] = param1;
            }
            _loc2_++;
         }
      }
      
      public function getProgress() : int
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this._achievements)
         {
            _loc1_ += !!_loc2_.finalLevel ? _loc2_.level : _loc2_.level - 1;
         }
         return _loc1_;
      }
      
      public function getMaxProgress() : int
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         for each(_loc2_ in this._achievements)
         {
            _loc1_ += _loc2_.levelCount;
         }
         return _loc1_;
      }
      
      public function get code() : String
      {
         return this.var_2503;
      }
      
      public function get achievements() : Array
      {
         return this._achievements;
      }
   }
}
