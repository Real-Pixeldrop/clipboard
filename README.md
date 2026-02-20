# ClipBoard

Gestionnaire de presse-papiers léger. Garde tes 10 derniers éléments copiés, toujours accessibles dans la menu bar.

## Download

[Télécharger ClipBoard.zip](https://github.com/Real-Pixeldrop/clipboard/releases/latest/download/ClipBoard.zip)

1. Télécharge le zip
2. Dézipe
3. Glisse dans Applications
4. Double-clic. C'est prêt.

## Comment ça marche

1. **Copie** quelque chose (Cmd+C)
2. **Clique** sur l'icône ClipBoard dans la menu bar
3. **Retrouve** tes 10 derniers éléments copiés
4. **Clique** sur un élément pour le remettre dans le presse-papiers

## From source

```bash
git clone https://github.com/Real-Pixeldrop/clipboard.git
cd clipboard
swift build -c release
cp -r .build/release/ClipBoard.app /Applications/ 2>/dev/null || \
  cp .build/release/ClipBoard /Applications/
```

## One-liner install

```bash
curl -sL https://github.com/Real-Pixeldrop/clipboard/releases/latest/download/ClipBoard.zip -o /tmp/cb.zip && unzip -o /tmp/cb.zip -d /Applications/ && xattr -cr /Applications/ClipBoard.app && open /Applications/ClipBoard.app
```
