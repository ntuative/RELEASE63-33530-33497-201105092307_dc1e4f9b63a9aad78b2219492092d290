package com.sulake.core.assets
{
   public class AssetTypeDeclaration
   {
       
      
      private var var_2511:String;
      
      private var var_2509:Class;
      
      private var var_2510:Class;
      
      private var var_1842:Array;
      
      public function AssetTypeDeclaration(param1:String, param2:Class, param3:Class, ... rest)
      {
         super();
         this.var_2511 = param1;
         this.var_2509 = param2;
         this.var_2510 = param3;
         if(rest == null)
         {
            this.var_1842 = new Array();
         }
         else
         {
            this.var_1842 = rest;
         }
      }
      
      public function get mimeType() : String
      {
         return this.var_2511;
      }
      
      public function get assetClass() : Class
      {
         return this.var_2509;
      }
      
      public function get loaderClass() : Class
      {
         return this.var_2510;
      }
      
      public function get fileTypes() : Array
      {
         return this.var_1842;
      }
   }
}
