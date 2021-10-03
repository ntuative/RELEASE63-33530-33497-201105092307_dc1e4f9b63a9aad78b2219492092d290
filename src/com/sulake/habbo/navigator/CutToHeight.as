package com.sulake.habbo.navigator
{
   import com.sulake.core.window.components.ITextWindow;
   
   public class CutToHeight implements BinarySearchTest
   {
       
      
      private var var_178:String;
      
      private var _text:ITextWindow;
      
      private var var_323:int;
      
      public function CutToHeight()
      {
         super();
      }
      
      public function test(param1:int) : Boolean
      {
         this._text.text = this.var_178.substring(0,param1) + "...";
         return this._text.textHeight > this.var_323;
      }
      
      public function beforeSearch(param1:String, param2:ITextWindow, param3:int) : void
      {
         this.var_178 = param1;
         this._text = param2;
         this.var_323 = param3;
      }
   }
}
