# flutfirebase
Meu flutter app com firebase


Gerar SHA-1 no terminal para firbase android 

Go to the project folder in the terminal.

Mac keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

Windows keytool -list -v -keystore "\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

Linux keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

acaba com as recomendacoes do firbase e por fim as dependecias que seram instaladas atraves do pubspec.yaml
```yaml
dependencies:
    # [recomendado] se nao da um problema se nao colocar na sua dependencia
    firebase_core: ^1.4.0 
    cloud_firestore: ^2.4.0
    firebase_storage: ^10.0.0

```

SE for a rodar pela primeira vez possa vir dar erro de Dex
que quer dizer os codigos java quando compilados geram um arquivo .jar e 
flutter gera um arquivo .dex e firbase gerar arquivos dex maiores e k ests sao limitado
dai da um pau , para solucionar esse trouble precisar settar :

android/app/build.gradle
```groove
dependencies {
    def multidex_version = "2.0.1"
    implementation "androidx.multidex:multidex:$multidex_version"
}
```
If you aren't using AndroidX, add the following deprecated support library dependency instead:
```groove

dependencies {
    implementation 'com.android.support:multidex:1.0.3'
}
```
 e no mesmo grandle do android/app/
 adicione no defaultConfig que multiDexEnabled=true
```groove

android {
    defaultConfig {
        ...
        minSdkVersion 15 
        targetSdkVersion 28
        multiDexEnabled true
    }
    ...
}

dependencies {
    implementation "androidx.multidex:multidex:2.0.1"
}



```