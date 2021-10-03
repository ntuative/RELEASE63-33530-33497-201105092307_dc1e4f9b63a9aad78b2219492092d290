package com.sulake.habbo.avatar.structure.parts
{
   public class PartDefinition
   {
       
      
      private var var_2715:String;
      
      private var var_1967:String;
      
      private var var_2714:String;
      
      private var var_1968:Boolean;
      
      private var var_1966:int = -1;
      
      public function PartDefinition(param1:XML)
      {
         super();
         this.var_2715 = String(param1["set-type"]);
         this.var_1967 = String(param1["flipped-set-type"]);
         this.var_2714 = String(param1["remove-set-type"]);
         this.var_1968 = false;
      }
      
      public function hasStaticId() : Boolean
      {
         return this.var_1966 >= 0;
      }
      
      public function get staticId() : int
      {
         return this.var_1966;
      }
      
      public function set staticId(param1:int) : void
      {
         this.var_1966 = param1;
      }
      
      public function get setType() : String
      {
         return this.var_2715;
      }
      
      public function get flippedSetType() : String
      {
         return this.var_1967;
      }
      
      public function get removeSetType() : String
      {
         return this.var_2714;
      }
      
      public function get appendToFigure() : Boolean
      {
         return this.var_1968;
      }
      
      public function set appendToFigure(param1:Boolean) : void
      {
         this.var_1968 = param1;
      }
      
      public function set flippedSetType(param1:String) : void
      {
         this.var_1967 = param1;
      }
   }
}
