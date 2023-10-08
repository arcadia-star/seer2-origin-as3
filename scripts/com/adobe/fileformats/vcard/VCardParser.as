package com.adobe.fileformats.vcard
{
   import mx.utils.Base64Decoder;
   import mx.utils.StringUtil;
   
   public class VCardParser
   {
       
      
      public function VCardParser()
      {
         super();
      }
      
      public static function parse(param1:String) : Array
      {
         var _loc4_:VCard = null;
         var _loc5_:* = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc14_:Phone = null;
         var _loc15_:String = null;
         var _loc16_:Array = null;
         var _loc17_:String = null;
         var _loc18_:Email = null;
         var _loc19_:String = null;
         var _loc20_:Array = null;
         var _loc21_:String = null;
         var _loc22_:Array = null;
         var _loc23_:Address = null;
         var _loc24_:uint = 0;
         var _loc25_:String = null;
         var _loc26_:String = null;
         var _loc27_:Array = null;
         var _loc28_:String = null;
         var _loc29_:String = null;
         var _loc30_:uint = 0;
         var _loc31_:Base64Decoder = null;
         var _loc2_:Array = new Array();
         var _loc3_:Array = param1.split(/\r\n/);
         var _loc8_:uint = 0;
         while(_loc8_ < _loc3_.length)
         {
            if((_loc7_ = String(_loc3_[_loc8_])) == "BEGIN:VCARD")
            {
               _loc4_ = new VCard();
            }
            else if(_loc7_ == "END:VCARD")
            {
               if(_loc4_ != null)
               {
                  _loc2_.push(_loc4_);
               }
            }
            else if(_loc7_.search(/^ORG/i) != -1)
            {
               _loc10_ = (_loc9_ = _loc7_.substring(4,_loc7_.length)).split(";");
               for each(_loc11_ in _loc10_)
               {
                  if(StringUtil.trim(_loc11_).length > 0)
                  {
                     _loc4_.orgs.push(_loc11_);
                  }
               }
            }
            else if(_loc7_.search(/^TITLE/i) != -1)
            {
               _loc12_ = _loc7_.substring(6,_loc7_.length);
               _loc4_.title = _loc12_;
            }
            else if(_loc7_.search(/^FN:/i) != -1)
            {
               _loc13_ = _loc7_.substring(3,_loc7_.length);
               _loc4_.fullName = _loc13_;
            }
            else if(_loc7_.search(/^TEL/i) != -1)
            {
               _loc5_ = new String();
               _loc6_ = new String();
               _loc14_ = new Phone();
               _loc16_ = _loc7_.split(";");
               for each(_loc17_ in _loc16_)
               {
                  if(_loc17_.search(/^TYPE=/i) != -1)
                  {
                     if(_loc17_.indexOf(":") != -1)
                     {
                        _loc6_ = _loc17_.substring(5,_loc17_.indexOf(":"));
                        _loc15_ = _loc17_.substring(_loc17_.indexOf(":") + 1,_loc17_.length);
                     }
                     else
                     {
                        _loc6_ = _loc17_.substring(5,_loc17_.length);
                     }
                     if((_loc6_ = _loc6_.toLocaleLowerCase()) != "pref")
                     {
                        if(_loc5_.length != 0)
                        {
                           _loc5_ += " ";
                        }
                        _loc5_ += _loc6_;
                     }
                  }
               }
               if(_loc5_.length > 0 && _loc15_ != null)
               {
                  _loc14_.type = _loc5_;
                  _loc14_.number = _loc15_;
               }
               _loc4_.phones.push(_loc14_);
            }
            else if(_loc7_.search(/^EMAIL/i) != -1)
            {
               _loc5_ = new String();
               _loc6_ = new String();
               _loc18_ = new Email();
               _loc20_ = _loc7_.split(";");
               for each(_loc21_ in _loc20_)
               {
                  if(_loc21_.search(/^TYPE=/i) != -1)
                  {
                     if(_loc21_.indexOf(":") != -1)
                     {
                        _loc6_ = _loc21_.substring(5,_loc21_.indexOf(":"));
                        _loc19_ = _loc21_.substring(_loc21_.indexOf(":") + 1,_loc21_.length);
                     }
                     else
                     {
                        _loc6_ = _loc21_.substring(5,_loc21_.length);
                     }
                     if(!((_loc6_ = _loc6_.toLocaleLowerCase()) == "pref" || _loc6_ == "internet"))
                     {
                        if(_loc5_.length != 0)
                        {
                           _loc5_ += " ";
                        }
                        _loc5_ += _loc6_;
                     }
                  }
               }
               if(_loc5_.length > 0 && _loc19_ != null)
               {
                  _loc18_.type = _loc5_;
                  _loc18_.address = _loc19_;
               }
               _loc4_.emails.push(_loc18_);
            }
            else if(_loc7_.indexOf("ADR;") != -1)
            {
               _loc22_ = _loc7_.split(";");
               _loc23_ = new Address();
               _loc24_ = 0;
               while(_loc24_ < _loc22_.length)
               {
                  if((_loc25_ = String(_loc22_[_loc24_])).search(/^home:+$/i) != -1)
                  {
                     _loc23_.type = "home";
                  }
                  else if(_loc25_.search(/^work:+$/i) != -1)
                  {
                     _loc23_.type = "work";
                  }
                  if(_loc25_.search(/^type=/i) != -1)
                  {
                     if((_loc26_ = (_loc25_ = _loc25_.replace(/:/,"")).substring(5,_loc25_.length).toLowerCase()) != "pref")
                     {
                        if(_loc26_.indexOf("home") != -1)
                        {
                           _loc26_ = "home";
                        }
                        else if(_loc26_.indexOf("work") != -1)
                        {
                           _loc26_ = "work";
                        }
                        else if(_loc26_.indexOf(",") != -1)
                        {
                           _loc27_ = _loc26_.split(",");
                           for each(_loc28_ in _loc27_)
                           {
                              if(_loc28_ != "pref")
                              {
                                 _loc26_ = _loc28_;
                                 break;
                              }
                           }
                        }
                        _loc23_.type = _loc26_;
                     }
                  }
                  else if(_loc25_.search(/^\d/) != -1 && _loc23_.street == null)
                  {
                     _loc23_.street = _loc25_.replace(/\\n/,"");
                     _loc23_.city = _loc22_[_loc24_ + 1];
                     _loc23_.state = _loc22_[_loc24_ + 2];
                     _loc23_.postalCode = _loc22_[_loc24_ + 3];
                  }
                  _loc24_++;
               }
               if(_loc23_.type != null && _loc23_.street != null)
               {
                  _loc4_.addresses.push(_loc23_);
               }
            }
            else if(_loc7_.search(/^PHOTO;BASE64/i) != -1)
            {
               _loc29_ = new String();
               _loc30_ = uint(_loc8_ + 1);
               while(_loc30_ < _loc3_.length)
               {
                  _loc29_ += _loc3_[_loc30_];
                  if(_loc3_[_loc30_].indexOf("=") != -1)
                  {
                     (_loc31_ = new Base64Decoder()).decode(_loc29_);
                     _loc4_.image = _loc31_.flush();
                     break;
                  }
                  _loc30_++;
               }
            }
            _loc8_++;
         }
         return _loc2_;
      }
   }
}
