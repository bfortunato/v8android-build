# v8android-build

Docker file to build Google V8 JavaScript Engine v5.6 for Android

``` 
docker build -t androidv8
```

Take a good coffee and wait... It's a long process!!!

After the successfull build, files are located in /v8/v8/out directory of container. If you want to copy on your host, type...

```
docker cp androidv8:/v8/v8/out <your-host-path>
```


