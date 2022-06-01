if (document.URL.match(/new/) || document.URL.match(/edit/)) {
  document.addEventListener('DOMContentLoaded', () => {
    const createImageHTML = (blob) => {
      const imageElement = document.getElementById('post-image-preview');
      // HTML要素の<img>を作成する
      const blobImage = document.createElement('img');
      blobImage.setAttribute('class', 'post-preview');
      // ここで実際に文字列の画像をsrcを渡す
      blobImage.setAttribute('src', blob);
      // 実際にpost-image-previewの中にclassなどを持たせたimg要素を入れる
      imageElement.appendChild(blobImage);
    };
    document.getElementById('post_trail_image').addEventListener('change', (e) => {
      // img要素を取得（img要素の一番最初の子要素を取得するらしい）
      const imageContent = document.querySelector('img')
      if (imageContent) {
        imageContent.remove();
      }
      const file = e.target.files[0];
      // ↑で取得したファイルを文字列に変換する
      const blob = window.URL.createObjectURL(file);
      createImageHTML(blob);
    });
  });
}