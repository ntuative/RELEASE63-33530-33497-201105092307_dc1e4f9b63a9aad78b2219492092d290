package com.sulake.habbo.communication.messages.incoming.inventory.trading
{
   public class ItemDataStructure
   {
       
      
      private var var_2157:int;
      
      private var var_1517:String;
      
      private var var_2579:int;
      
      private var var_2577:int;
      
      private var _category:int;
      
      private var var_2136:String;
      
      private var var_1499:int;
      
      private var var_2576:int;
      
      private var var_2575:int;
      
      private var var_2578:int;
      
      private var var_2580:int;
      
      private var var_2574:Boolean;
      
      private var var_2973:int;
      
      public function ItemDataStructure(param1:int, param2:String, param3:int, param4:int, param5:int, param6:String, param7:int, param8:int, param9:int, param10:int, param11:int, param12:Boolean)
      {
         super();
         this.var_2157 = param1;
         this.var_1517 = param2;
         this.var_2579 = param3;
         this.var_2577 = param4;
         this._category = param5;
         this.var_2136 = param6;
         this.var_1499 = param7;
         this.var_2576 = param8;
         this.var_2575 = param9;
         this.var_2578 = param10;
         this.var_2580 = param11;
         this.var_2574 = param12;
      }
      
      public function get itemID() : int
      {
         return this.var_2157;
      }
      
      public function get itemType() : String
      {
         return this.var_1517;
      }
      
      public function get roomItemID() : int
      {
         return this.var_2579;
      }
      
      public function get itemTypeID() : int
      {
         return this.var_2577;
      }
      
      public function get category() : int
      {
         return this._category;
      }
      
      public function get stuffData() : String
      {
         return this.var_2136;
      }
      
      public function get extra() : int
      {
         return this.var_1499;
      }
      
      public function get timeToExpiration() : int
      {
         return this.var_2576;
      }
      
      public function get creationDay() : int
      {
         return this.var_2575;
      }
      
      public function get creationMonth() : int
      {
         return this.var_2578;
      }
      
      public function get creationYear() : int
      {
         return this.var_2580;
      }
      
      public function get groupable() : Boolean
      {
         return this.var_2574;
      }
      
      public function get songID() : int
      {
         return this.var_1499;
      }
   }
}
