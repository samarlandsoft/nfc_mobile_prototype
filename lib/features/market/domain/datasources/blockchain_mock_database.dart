class BlockchainMockDatabase {
  static const Map<String, String> sweaterTokenURLs = {
    '23': 'https://ayfljnr4u6mracm65yupl2pjk2to3z54nyeycolu3zg7hrob7otq.arweave.net/Bgq0tjynmRAJnu4o9enpVqbt57xuCYE5dN5N88XB-6c',
    '24': 'https://arweave.net/fg2pLrDroJ8x5rrGMAV7IkqTjpGFXssOqVOiDAsbN1o',
    '25': 'https://arweave.net/gFylgBhCTE_3-_RVg8sG_6ZOt7OnwiQ6fHr35KT9WdU',
    '26': 'https://arweave.net/1vQiGcK52SV789sg0QsubyUm9FM636TzRM-nun0oxCE',
    '27': 'https://arweave.net/syj0aBB5Vw-MdhFg-PGFUGCKz2NqQPrr8dpXF7QSKA8',
    '28': 'https://arweave.net/4kZKRGOd8E4ogKjlfCJzlGOsoiNOySAMPLSCmXM0R7o',
    '29': 'https://arweave.net/4o8raJBR_6-RIT9UhHltVd9bde-BxYtSbq5sUtW9vdY',
    '30': 'https://arweave.net/kgpI-YyxHyvSYggm1nQHUKTRLsP84BIBdFeviaqPux0',
    '31': 'https://arweave.net/ewfyxCAWx9qnNJhh1me9xHHEByu_-KqvqSRnieHG_ds',
    '32': 'https://arweave.net/Kx98A6WLu486g91TinTkPdk4NQIZizhzyjjprXHcunE',
    '33': 'https://arweave.net/PicpsDfdPixlO01H_sgpHB2VVtG-oIFDbn7Q_LSbc2s',
    '34': 'https://arweave.net/tdUPPPujPDf311VfUA9NaVpEQHWKLmEReh19WuX2E-g',
    '35': 'https://arweave.net/VifC7MEGDHUYjvPMElaF7NzFYQwXtz7hrG5DgsVgt3c',
    '36': 'https://arweave.net/5x40U-8ynHrV34OxBnLWecTtZA9F3ICv4yci6-m3i5A',
    '37': 'https://arweave.net/lmZxBO9jp97yZFeGki0lrmgk1U0HNRzhNyAeT7dhhYU',
    '38': 'https://arweave.net/E3Jp223j2p8a3IF_MSkn1ObPUbEdqS3vj4iXe47K1BA',
    '39': 'https://arweave.net/W5MBVfFOIJ3vhRtkK393NQj1nfrYGaf4TqYa6HwbBA4',
    '40': 'https://arweave.net/Z29a4qXGZzU_R2p8wYdDFq9umCen4b86BljMGh4x5gY',
    '41': 'https://arweave.net/gP9PIHc_vPHQLSmGYfdicbNiKtEiJV8MZo7OJuY2hZQ',
    '42': 'https://arweave.net/xPLXlORmnFuKp_nni8xBRr5MESlRRzQtuEO0POphWWw',
    '2': 'https://arweave.net/LPMhIy3vUj87vDbXDqz2ILWBKBFB3EBP57NyJjJq-oo',
    '3': 'https://arweave.net/R1UswktsUMTbC-hXtwqVc_oHzdsXdTYHjRVJo2SL4ww',
    '4': 'https://arweave.net/BegcAbIOKerOlQJtpZ3xP5dlP4fYYbr0VffqlRpt6kw',
    '5': 'https://arweave.net/_t66dxbbrLwGgnVjRX6LegfO_BsKaUZ9i3VHuXwK55g',
    '6': 'https://arweave.net/iU6qMbzJV_JKO3Yufhw8FkwPbouuu_u8ZIBNv3UxoYA',
    '7': 'https://arweave.net/qABk9NeAnuyKMh3wzc4GXczVv3_UspySog7jTIX9uSM',
    '8': 'https://arweave.net/Zgz7z08hEbQjJKL_4H0qXSWa52-R6mWP_fb23jMUzdU',
    '9': 'https://arweave.net/-EoB4xSziIFKJ4MoeVvD27kIeAMEv9XNeUIP5WYS36o',
    '10': 'https://arweave.net/zVYIk4glY-FISTN7vlLIQ87jE6jFuTWUg5SHyBdwxng',
    '11': 'https://arweave.net/lj9v41IQCgIqq7hjOVOnPjxMr2YH1HsOnfIu2ZfRtSo',
    '13': 'https://arweave.net/BFsfA9ClguskOSIuv2F7EMZMUL4lnF3v97eXDYyXBgc',
    '14': 'https://arweave.net/Ic7JQa5xZUwVR57dJswajmUWncwLCJWxwu1cHyXrEM0',
    '15': 'https://arweave.net/pSywUA76cjP_uUt7OtoEfwV_J7Z_WN6ZPMYmU9jKUAc',
    '16': 'https://arweave.net/1tISAWfAJORY8EWrdX0HkJcqdIMAwecM-5akQA3SjHs',
    '17': 'https://arweave.net/0gqQNhyYTdm8jJJfCcWCye7WXPgt6uvMN2z2_PsVVTY',
    '18': 'https://arweave.net/Fn1t4TIJlQhjcKyG5QzfzhVwk0rH5MsFUywzlOVUEms',
    '19': 'https://arweave.net/4BxJcS-jYNZDe3OV0nkqIkYETUEe8QLaIIP3Wh0lfko',
    '20': 'https://arweave.net/zvBVpiegVVMJTXux0tzI6JE2LMtNA3iB4_RpcfKOGNE',
    '21': 'https://arweave.net/XX7BOMBTQmiy1WY_uVsrDyGAP8HnkpxI2Nr68ncQ7ys',
    '22': 'https://arweave.net/O68pp4_LZMtfpFVRwcEvz82IbNpbISpPXBdnutg2eN0',
  };

  static const Map<int, String> btcIDSweaterURLs = {
    1: 'https://ayfljnr4u6mracm65yupl2pjk2to3z54nyeycolu3zg7hrob7otq.arweave.net/Bgq0tjynmRAJnu4o9enpVqbt57xuCYE5dN5N88XB-6c',
    2: 'https://arweave.net/fg2pLrDroJ8x5rrGMAV7IkqTjpGFXssOqVOiDAsbN1o',
    3: 'https://arweave.net/gFylgBhCTE_3-_RVg8sG_6ZOt7OnwiQ6fHr35KT9WdU',
    4: 'https://arweave.net/1vQiGcK52SV789sg0QsubyUm9FM636TzRM-nun0oxCE',
    5: 'https://arweave.net/syj0aBB5Vw-MdhFg-PGFUGCKz2NqQPrr8dpXF7QSKA8',
    6: 'https://arweave.net/4kZKRGOd8E4ogKjlfCJzlGOsoiNOySAMPLSCmXM0R7o',
    7: 'https://arweave.net/4o8raJBR_6-RIT9UhHltVd9bde-BxYtSbq5sUtW9vdY',
    8: 'https://arweave.net/kgpI-YyxHyvSYggm1nQHUKTRLsP84BIBdFeviaqPux0',
    9: 'https://arweave.net/ewfyxCAWx9qnNJhh1me9xHHEByu_-KqvqSRnieHG_ds',
    10: 'https://arweave.net/Kx98A6WLu486g91TinTkPdk4NQIZizhzyjjprXHcunE',
    11: 'https://arweave.net/PicpsDfdPixlO01H_sgpHB2VVtG-oIFDbn7Q_LSbc2s',
    12: 'https://arweave.net/tdUPPPujPDf311VfUA9NaVpEQHWKLmEReh19WuX2E-g',
    13: 'https://arweave.net/VifC7MEGDHUYjvPMElaF7NzFYQwXtz7hrG5DgsVgt3c',
    14: 'https://arweave.net/5x40U-8ynHrV34OxBnLWecTtZA9F3ICv4yci6-m3i5A',
    15: 'https://arweave.net/lmZxBO9jp97yZFeGki0lrmgk1U0HNRzhNyAeT7dhhYU',
    16: 'https://arweave.net/E3Jp223j2p8a3IF_MSkn1ObPUbEdqS3vj4iXe47K1BA',
    17: 'https://arweave.net/W5MBVfFOIJ3vhRtkK393NQj1nfrYGaf4TqYa6HwbBA4',
    18: 'https://arweave.net/Z29a4qXGZzU_R2p8wYdDFq9umCen4b86BljMGh4x5gY',
    19: 'https://arweave.net/gP9PIHc_vPHQLSmGYfdicbNiKtEiJV8MZo7OJuY2hZQ',
    20: 'https://arweave.net/xPLXlORmnFuKp_nni8xBRr5MESlRRzQtuEO0POphWWw',
  };

  static const Map<int, String> ethIDSweaterURLs = {
    1: 'https://arweave.net/LPMhIy3vUj87vDbXDqz2ILWBKBFB3EBP57NyJjJq-oo',
    2: 'https://arweave.net/R1UswktsUMTbC-hXtwqVc_oHzdsXdTYHjRVJo2SL4ww',
    3: 'https://arweave.net/BegcAbIOKerOlQJtpZ3xP5dlP4fYYbr0VffqlRpt6kw',
    4: 'https://arweave.net/_t66dxbbrLwGgnVjRX6LegfO_BsKaUZ9i3VHuXwK55g',
    5: 'https://arweave.net/iU6qMbzJV_JKO3Yufhw8FkwPbouuu_u8ZIBNv3UxoYA',
    6: 'https://arweave.net/qABk9NeAnuyKMh3wzc4GXczVv3_UspySog7jTIX9uSM',
    7: 'https://arweave.net/Zgz7z08hEbQjJKL_4H0qXSWa52-R6mWP_fb23jMUzdU',
    8: 'https://arweave.net/-EoB4xSziIFKJ4MoeVvD27kIeAMEv9XNeUIP5WYS36o',
    9: 'https://arweave.net/zVYIk4glY-FISTN7vlLIQ87jE6jFuTWUg5SHyBdwxng',
    10: 'https://arweave.net/lj9v41IQCgIqq7hjOVOnPjxMr2YH1HsOnfIu2ZfRtSo',
    11: 'https://arweave.net/BFsfA9ClguskOSIuv2F7EMZMUL4lnF3v97eXDYyXBgc',
    12: 'https://arweave.net/Ic7JQa5xZUwVR57dJswajmUWncwLCJWxwu1cHyXrEM0',
    13: 'https://arweave.net/pSywUA76cjP_uUt7OtoEfwV_J7Z_WN6ZPMYmU9jKUAc',
    14: 'https://arweave.net/1tISAWfAJORY8EWrdX0HkJcqdIMAwecM-5akQA3SjHs',
    15: 'https://arweave.net/0gqQNhyYTdm8jJJfCcWCye7WXPgt6uvMN2z2_PsVVTY',
    16: 'https://arweave.net/Fn1t4TIJlQhjcKyG5QzfzhVwk0rH5MsFUywzlOVUEms',
    17: 'https://arweave.net/4BxJcS-jYNZDe3OV0nkqIkYETUEe8QLaIIP3Wh0lfko',
    18: 'https://arweave.net/zvBVpiegVVMJTXux0tzI6JE2LMtNA3iB4_RpcfKOGNE',
    19: 'https://arweave.net/XX7BOMBTQmiy1WY_uVsrDyGAP8HnkpxI2Nr68ncQ7ys',
    20: 'https://arweave.net/O68pp4_LZMtfpFVRwcEvz82IbNpbISpPXBdnutg2eN0',
  };

  static int getAmountSoldSweaters(String chipUrl, bool isBTC) {
    late int index;

    if (isBTC) {
      btcIDSweaterURLs.forEach((id, url) {
        if (chipUrl == url) {
          index = id;
        }
      });
    } else {
      ethIDSweaterURLs.forEach((id, url) {
        if (chipUrl == url) {
          index = id;
        }
      });
    }

    return index;
  }
}