package com.sangeun.teamf.service;

import com.sangeun.teamf.dto.Voc;
import com.sangeun.teamf.dto.VocProgress;
import com.sangeun.teamf.repository.VocRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class VocService {
    @Autowired
    VocRepository vocRepository;

    @Transactional
    public void write(Voc voc){
        vocRepository.save(voc);
    }

    @Transactional(readOnly = true)
    public Page<Voc> vocPage(Pageable pageable){
        return vocRepository.findAll(pageable);
    }

    @Transactional(readOnly = true)
    public List<Object> cVocList(int clientNum){
        return vocRepository.cVocList(clientNum);
    }

    @Transactional(readOnly = true)
    public Voc findById(int vocNum){
        return vocRepository.findById(vocNum)
                .orElseThrow(()-> {
                    return new IllegalArgumentException("글 찾기 실패 : 기존 글을 찾을 수 없습니다.");
                });
    }

    @Transactional
    public Voc chkDriver(int vocNum){
        Voc voc = vocRepository.findById(vocNum)
                .orElseThrow(()-> {
                    return new IllegalArgumentException("글 찾기 실패 : 기존 글을 찾을 수 없습니다.");
                });
        voc.setVocProgress(VocProgress.DRICHK);
        voc.setChkDriver(true);
        return voc;
    }

}
