package com.sulake.habbo.avatar
{
   import com.sulake.core.utils.Map;
   
   public class AvatarFigureContainer implements IAvatarFigureContainer
   {
       
      
      private var _parts:Map;
      
      public function AvatarFigureContainer(param1:String)
      {
         super();
         this._parts = new Map();
         this.parseFigureString(param1);
      }
      
      public function getPartTypeIds() : Array
      {
         return this.getParts().getKeys();
      }
      
      public function hasPartType(param1:String) : Boolean
      {
         return this.getParts().getValue(param1) != null;
      }
      
      public function getPartSetId(param1:String) : int
      {
         var _loc2_:Map = this.getParts().getValue(param1) as Map;
         if(_loc2_ != null)
         {
            return _loc2_.getValue("setid") as int;
         }
         return 0;
      }
      
      public function getPartColorIds(param1:String) : Array
      {
         var _loc2_:Map = this.getParts().getValue(param1) as Map;
         if(_loc2_ != null)
         {
            return _loc2_.getValue("colorids") as Array;
         }
         return null;
      }
      
      public function updatePart(param1:String, param2:int, param3:Array) : void
      {
         var _loc4_:Map = new Map();
         _loc4_.add("type",param1);
         _loc4_.add("setid",param2);
         _loc4_.add("colorids",param3);
         var _loc5_:Map = this.getParts();
         _loc5_.remove(param1);
         _loc5_.add(param1,_loc4_);
      }
      
      public function removePart(param1:String) : void
      {
         this.getParts().remove(param1);
      }
      
      public function getFigureString() : String
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = [];
         for each(_loc2_ in this.getParts().getKeys())
         {
            _loc3_ = [];
            _loc3_.push(_loc2_);
            _loc3_.push(this.getPartSetId(_loc2_));
            _loc3_ = _loc3_.concat(this.getPartColorIds(_loc2_));
            _loc1_.push(_loc3_.join("-"));
         }
         return _loc1_.join(".");
      }
      
      private function getParts() : Map
      {
         if(this._parts == null)
         {
            this._parts = new Map();
         }
         return this._parts;
      }
      
      private function parseFigureString(param1:String) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         if(param1 == null)
         {
            param1 = "";
         }
         for each(_loc2_ in param1.split("."))
         {
            _loc3_ = _loc2_.split("-");
            if(_loc3_.length >= 2)
            {
               _loc4_ = String(_loc3_[0]);
               _loc5_ = parseInt(_loc3_[1]);
               _loc6_ = new Array();
               _loc7_ = 2;
               while(_loc7_ < _loc3_.length)
               {
                  _loc6_.push(parseInt(_loc3_[_loc7_]));
                  _loc7_++;
               }
               this.updatePart(_loc4_,_loc5_,_loc6_);
            }
         }
      }
   }
}
