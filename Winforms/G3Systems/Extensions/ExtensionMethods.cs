using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace G3Systems.Extensions
{
    public static class ExtensionMethods
    {
        /// <summary>
        /// Read string in value="" from appsettings in App.Config and convert to required type
        /// <appSettings><add key="" value=""/></appSettings>
        /// </summary>
        public static bool GetConfigSetting(this string key)
        {
            string val = ConfigurationManager.AppSettings[key] ?? "";
            bool result = false; 
            if (!string.IsNullOrEmpty(val))
            {
                bool typeDefault = default;
                result = (bool)Convert.ChangeType(val, typeDefault.GetTypeCode());
            }
            // Return false if key is empty
            return result;
        }
    }
}
