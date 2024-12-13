package com.cosaverde.service.impl;

import com.cosaverde.dao.CantonDao;
import com.cosaverde.domain.Canton;
import com.cosaverde.service.CantonService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cosaverde.domain.Canton;
import com.cosaverde.service.CantonService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author sfallas
 */
@Service
public class CantonServiceImpl implements CantonService {
    
     @Autowired
    private CantonDao cantonDao;
    @Override
    public List<Canton> getAllCantones() {
        return cantonDao.findAll();
    }
    
}
