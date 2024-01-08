package seer2.next.entry
{
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.app.config.SkillConfig;
import com.taomee.seer2.app.config.SkillSideEffectConfig;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.UILoader;

import flash.events.Event;
import flash.net.URLLoader;
import flash.net.URLRequest;

public class ReloadConfig
{


    public function ReloadConfig()
    {
        super();
    }

    public static function loadConfig() : void
    {
        loadUrl("config/binaryData/2_com.taomee.seer2.app.config.ItemConfig__itemXmlClass.xml",function(event:Event):void
        {
            ItemConfig.parseItems(XML(event.target.data));
        });
        loadUrl("config/binaryData/15_com.taomee.seer2.app.config.SkillConfig__movesXmlClass.xml",function(event:Event):void
        {
            SkillConfig.parseNormalSklls(XML(event.target.data));
        });
        loadUrl("config/binaryData/7_com.taomee.seer2.app.config.SkillSideEffectConfig__buffXmlClass.xml",function(event:Event):void
        {
            SkillSideEffectConfig.parseBuffConfigXml(XML(event.target.data));
        });
        loadUrl("config/binaryData/64_com.taomee.seer2.app.config.PetConfig__petXmlClass.xml",function(event:Event):void
        {
            loadUrl("config/binaryData/45_com.taomee.seer2.app.config.PetConfig__dictionaryXmlClass.xml",function(event:Event):void
            {
                loadUrl("config/binaryData/19_com.taomee.seer2.app.config.PetConfig__dialogXmlClass.xml",function(event:Event):void
                {
                    PetConfig.parseData(XML(event.target.data),XML(event.target.data),XML(event.target.data));
                });
            });
        });
    }

    public static function loadUrl(url:String, success:Function):void
    {
        var xmlLoader:URLLoader = new URLLoader();
        xmlLoader.addEventListener(Event.COMPLETE, success);
        var urlRequest:URLRequest = new URLRequest(url);
        xmlLoader.load(urlRequest);
    }
}
}
