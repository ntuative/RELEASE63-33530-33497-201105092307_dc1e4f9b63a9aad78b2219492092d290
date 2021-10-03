package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class CatalogPageMessageProductData
   {
      
      public static const const_66:String = "i";
      
      public static const const_78:String = "s";
      
      public static const const_205:String = "e";
       
      
      private var var_1440:String;
      
      private var var_2822:int;
      
      private var var_1168:String;
      
      private var var_1439:int;
      
      private var var_1810:int;
      
      public function CatalogPageMessageProductData(param1:IMessageDataWrapper)
      {
         super();
         this.var_1440 = param1.readString();
         this.var_2822 = param1.readInteger();
         this.var_1168 = param1.readString();
         this.var_1439 = param1.readInteger();
         this.var_1810 = param1.readInteger();
      }
      
      public function get productType() : String
      {
         return this.var_1440;
      }
      
      public function get furniClassId() : int
      {
         return this.var_2822;
      }
      
      public function get extraParam() : String
      {
         return this.var_1168;
      }
      
      public function get productCount() : int
      {
         return this.var_1439;
      }
      
      public function get expiration() : int
      {
         return this.var_1810;
      }
   }
}
