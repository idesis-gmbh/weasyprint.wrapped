using System.Runtime.InteropServices;

namespace Weasyprint.Wrapped;
public class ConfigurationProvider
{
    protected readonly string assetsFolder;
    protected readonly string workingFolder;
    private string baseUrl = ".";

    public ConfigurationProvider() : this(string.Empty, false, "weasyprinter", false) { }

    public ConfigurationProvider(string assetsFolder, bool isAssetsAbsolute, string workingFolder, bool isWorkingAbsolute)
    {
        this.assetsFolder = GetFolder(assetsFolder, isAssetsAbsolute);
        this.workingFolder = GetFolder(workingFolder, isWorkingAbsolute);
    }

    private string GetFolder(string folder, bool isAbsolute)
    {
        return isAbsolute ? folder : Path.Combine(AppContext.BaseDirectory, folder);
    }

    public string GetAsset()
    {
        string arch = RuntimeInformation.OSArchitecture switch
        {
            Architecture.X64 => "x64",
            Architecture.Arm64 => "aarch64",
            _ => string.Empty
        };

        string env = RuntimeInformation.IsOSPlatform(OSPlatform.Windows) ? "windows" :
            RuntimeInformation.IsOSPlatform(OSPlatform.OSX) ? "osx" : "linux";
        
        return Path.Combine(assetsFolder, $"standalone-{env}-{arch}.zip");
    }

    public string GetWorkingFolder()
        => workingFolder;

    public void SetBaseUrl(string baseUrl)
    {
        this.baseUrl = baseUrl;
    }

    public string GetBaseUrl()
        => baseUrl;
}
