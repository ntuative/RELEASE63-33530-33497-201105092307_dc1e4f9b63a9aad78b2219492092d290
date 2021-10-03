package com.sulake.habbo.communication.messages.incoming.inventory.furni
{
   public class FurniData
   {
       
      
      private var var_2534:int;
      
      private var var_1517:String;
      
      private var _objId:int;
      
      private var var_1639:int;
      
      private var _category:int;
      
      private var var_2136:String;
      
      private var var_2596:Boolean;
      
      private var var_2597:Boolean;
      
      private var var_2594:Boolean;
      
      private var var_2598:Boolean;
      
      private var var_2595:int;
      
      private var var_1499:int;
      
      private var var_2067:String = "";
      
      private var var_1650:int = -1;
      
      public function FurniData(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:Boolean, param8:Boolean, param9:Boolean, param10:Boolean, param11:int)
      {
         super();
         this.var_2534 = param1;
         this.var_1517 = param2;
         this._objId = param3;
         this.var_1639 = param4;
         this._category = param5;
         this.var_2136 = param6;
         this.var_2596 = param7;
         this.var_2597 = param8;
         this.var_2594 = param9;
         this.var_2598 = param10;
         this.var_2595 = param11;
      }
      
      public function setExtraData(param1:String, param2:int) : void
      {
         this.var_2067 = param1;
         this.var_1499 = param2;
      }
      
      public function get stripId() : int
      {
         return this.var_2534;
      }
      
      public function get itemType() : String
      {
         return this.var_1517;
      }
      
      public function get objId() : int
      {
         return this._objId;
      }
      
      public function get classId() : int
      {
         return this.var_1639;
      }
      
      public function get category() : int
      {
         return this._category;
      }
      
      public function get stuffData() : String
      {
         return this.var_2136;
      }
      
      public function get isGroupable() : Boolean
      {
         return this.var_2596;
      }
      
      public function get isRecyclable() : Boolean
      {
         return this.var_2597;
      }
      
      public function get isTradeable() : Boolean
      {
         return this.var_2594;
      }
      
      public function get isSellable() : Boolean
      {
         return this.var_2598;
      }
      
      public function get expiryTime() : int
      {
         return this.var_2595;
      }
      
      public function get slotId() : String
      {
         return this.var_2067;
      }
      
      public function get songId() : int
      {
         return this.var_1650;
      }
      
      public function get extra() : int
      {
         return this.var_1499;
      }
   }
}
