# choco-buck 🍫

To install [Buck](https://buckbuild.com/) via [Chocolatey](https://chocolatey.org/): 

```powershell=
choco install buck
```

To develop the package: 

```powershell=
choco pack buck.nuspec
choco install buck -s . -y 
```
