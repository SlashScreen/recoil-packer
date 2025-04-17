This is a simple tool for packing textures into the format expected by the default shader in [Recoil Engine](https://github.com/beyond-all-reason/spring). It's pretty simple to use.  
Click each box to open an image file. For some aspects, you will be asked to choose a channel from the image. This will be the channel read from the image and packed into the proper channel expected by the shader; this is useful if you have multiple kinds of information baked into one image.  

Here's what it expects for each category:

- Color: RGB channels for the albedo.
- Team color: One channel for the part of the texture that will be colored with the team's color.
- Emission: One channel for any emissive parts of the texture.
- Specular: One channel for "some kind of specular multiplier". I have been told the formula used for this is weird in-engine, but I don't know the defails.
- Alpha cutout: One channel binary alpha mask for alpha scissoring.

"Pack textures" will ask you to choose a filepath. No extension is needed. It will append "_base" and "_extra" to the two images it exports. It currently only exports to DDS, as that's the most common texture type.

Improvements in the future:
- Be able to process an entire directory with automatic detection
- Be able to export any supported format, not just DDS
- Custom icon
- More in-app instructions
