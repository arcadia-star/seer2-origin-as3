package seer2.next.entry {

import com.taomee.seer2.app.MainEntry;

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.SecurityErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class DynConfig {
    public static var mainEntry:MainEntry;
    public static var itemConfigXML:XML;
    public static var buffConfigXML:XML;
    public static var movesConfigXML:XML;
    public static var hideMovesConfigXML:XML;
    public static var nonoActivityConfigXML:XML;
    public static var actCalendarConfigXML:XML;
    public static var shopPanelConfigXML:XML;
    public static var rightToolbarConfigXML:XML;
    public static var petConfigXML:XML;
    public static var dictionaryConfigXML:XML;

    private static function loadConfig():void {
        loadXML("config/binaryData/2_com.taomee.seer2.app.config.ItemConfig__itemXmlClass.xml", function (xml:XML):void {
            itemConfigXML = xml;
        });
        loadXML("config/binaryData/7_com.taomee.seer2.app.config.SkillSideEffectConfig__buffXmlClass.xml", function (xml:XML):void {
            buffConfigXML = xml;
        });
        loadXML("config/binaryData/15_com.taomee.seer2.app.config.SkillConfig__movesXmlClass.xml", function (xml:XML):void {
            movesConfigXML = xml;
        });
        loadXML("config/binaryData/23_com.taomee.seer2.app.config.SkillConfig__hideMovesXmlClass.xml", function (xml:XML):void {
            hideMovesConfigXML = xml;
        });
        loadXML("config/binaryData/21_com.taomee.seer2.app.config.NonoActivityConfig__xmlClass.xml", function (xml:XML):void {
            nonoActivityConfigXML = xml;
        });
        loadXML("config/binaryData/29_com.taomee.seer2.app.config.ActCalendarConfig__xml.xml", function (xml:XML):void {
            actCalendarConfigXML = xml;
        });
        loadXML("config/binaryData/44_com.taomee.seer2.app.config.ShopPanelConfig__class.xml", function (xml:XML):void {
            shopPanelConfigXML = xml;
        });
        loadXML("config/binaryData/59_com.taomee.seer2.app.rightToolbar.config.RightToolbarConfig__xmlClass.xml", function (xml:XML):void {
            rightToolbarConfigXML = xml;
        });
        loadXML("config/binaryData/64_com.taomee.seer2.app.config.PetConfig__petXmlClass.xml", function (xml:XML):void {
            petConfigXML = xml;
        });
        loadXML("config/binaryData/45_com.taomee.seer2.app.config.PetConfig__dictionaryXmlClass.xml", function (xml:XML):void {
            dictionaryConfigXML = xml;
        });
        loadXML("config/dyn-client-config.xml", function (xml:XML):void {
            DynSwitch.loadConfig(xml);
        })
    }

    private static function loadXML(url:String, success:Function):void {
        loadingCnt += 1;
        var loader:URLLoader = new URLLoader();
        var onLoaderComplete:Function = function (event:Event):void {
            var loader:URLLoader = event.target as URLLoader;
            var xml:XML = new XML(loader.data);
            success(xml);
            loadingCnt -= 1;
            tryCallback();
        };
        var onLoaderError:Function = function (event:Event):void {
            trace("DynConfig loadXML error:", url);
            loadingCnt -= 1;
            tryCallback();
        }
        loader.addEventListener(Event.COMPLETE, onLoaderComplete);
        loader.addEventListener(IOErrorEvent.IO_ERROR, onLoaderError);
        loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onLoaderError);
        var request:URLRequest = new URLRequest(url);
        loader.load(request);
    }

    private static function tryCallback():void {
        if (loadingCnt == 0 && callback) {
            var cb:Function = callback;
            callback = null;
            cb();
        }
    }

    private static var callback:Function;
    private static var loadingCnt:int;

    public static function loadConfigCallback(cb:Function):void {
        callback = cb;
        loadConfig();
    }
}
}
