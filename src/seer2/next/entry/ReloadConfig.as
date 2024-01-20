package seer2.next.entry
{
import com.taomee.seer2.app.config.ActCalendarConfig;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.config.NonoActivityConfig;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.config.ShopPanelConfig;
import com.taomee.seer2.app.config.SkillConfig;
import com.taomee.seer2.app.config.SkillSideEffectConfig;
import com.taomee.seer2.app.rightToolbar.config.RightToolbarConfig;

import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class ReloadConfig
{

      private static var _petConfigXML:XML;
      private static var _dictionaryConfigXML:XML;
      private static var _dialogConfigXML:XML;

      public function ReloadConfig()
      {
            super();
      }

      public static function loadConfig():void
      {
            loadXML("config/binaryData/2_com.taomee.seer2.app.config.ItemConfig__itemXmlClass.xml", function (xml:XML):void
            {
                  ItemConfig.parseItems(xml);
            });
            loadXML("config/binaryData/7_com.taomee.seer2.app.config.SkillSideEffectConfig__buffXmlClass.xml", function (xml:XML):void
            {
                  SkillSideEffectConfig.parseBuffConfigXml(xml);
            });
            loadXML("config/binaryData/15_com.taomee.seer2.app.config.SkillConfig__movesXmlClass.xml", function (xml:XML):void
            {
                  SkillConfig.parseNormalSklls(xml);
            });
            loadXML("config/binaryData/21_com.taomee.seer2.app.config.NonoActivityConfig__xmlClass.xml", function (xml:XML):void
            {
                  NonoActivityConfig.loadConfig(xml);
            });
            loadXML("config/binaryData/29_com.taomee.seer2.app.config.ActCalendarConfig__xml.xml", function (xml:XML):void
            {
                  ActCalendarConfig.loadConfig(xml);
            });

            loadXML("config/binaryData/44_com.taomee.seer2.app.config.ShopPanelConfig__class.xml", function (xml:XML):void
            {
                  ShopPanelConfig.loadConfig(xml);
            });
//            loadXML("config/binaryData/59_com.taomee.seer2.app.rightToolbar.config.RightToolbarConfig__xmlClass.xml", function (xml:XML):void
//            {
//                  RightToolbarConfig.loadConfig(xml)
//            });
            loadXML("config/binaryData/64_com.taomee.seer2.app.config.PetConfig__petXmlClass.xml", function (xml:XML):void
            {
                  _petConfigXML = xml;
                  tryLoadPetConfig();
            });
            loadXML("config/binaryData/45_com.taomee.seer2.app.config.PetConfig__dictionaryXmlClass.xml", function (xml:XML):void
            {
                  _dictionaryConfigXML = xml;
                  tryLoadPetConfig();
            });
            loadXML("config/binaryData/19_com.taomee.seer2.app.config.PetConfig__dialogXmlClass.xml", function (xml:XML):void
            {
                  _dialogConfigXML = xml;
                  tryLoadPetConfig();
            });
      }

      private static function tryLoadPetConfig():void
      {
            if (_petConfigXML && _dictionaryConfigXML && _dialogConfigXML)
            {
                  PetConfig.parseData(_petConfigXML, _dictionaryConfigXML, _dialogConfigXML);
            }
      }

      public static function loadXML(url:String, success:Function):void
      {
            var loader:URLLoader = new URLLoader();
            var onLoaderComplete:Function = function (event:Event):void
            {
                  var loader:URLLoader = event.target as URLLoader;
                  loader.removeEventListener(Event.COMPLETE, onLoaderComplete);
                  var xml:XML = new XML(loader.data);
                  success(xml);
            };
            loader.addEventListener(Event.COMPLETE, onLoaderComplete);
            var request:URLRequest = new URLRequest(url);
            loader.load(request);
      }
}
}
